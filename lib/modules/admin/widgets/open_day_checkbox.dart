import 'package:animate_do/animate_do.dart';
import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OpenDayCheckbox extends StatefulWidget {
  const OpenDayCheckbox(
      {Key? key,
      required this.title,
      this.checkValue = false,
      required this.onCheck,
      required this.onSelectedHourFrom,
      required this.onSelectedHourTo,
      this.initialFrom,
      this.initialTo})
      : super(key: key);

  final String title;
  final bool checkValue;
  final Function(bool?) onCheck;
  final Function(TimeOfDay?) onSelectedHourFrom;
  final Function(TimeOfDay?) onSelectedHourTo;
  final TimeOfDay? initialFrom;
  final TimeOfDay? initialTo;

  @override
  State<OpenDayCheckbox> createState() => _OpenDayCheckboxState();
}

class _OpenDayCheckboxState extends State<OpenDayCheckbox> {
  TimeOfDay _timeFrom = const TimeOfDay(hour: 9, minute: 0);
  String horaFrom = '';
  TimeOfDay _timeTo = const TimeOfDay(hour: 21, minute: 0);
  String horaTo = '';

  @override
  void initState() {
    if (widget.initialFrom != null) {
      _timeFrom = widget.initialFrom!;
      horaFrom =
          '${_timeFrom.hour.toString().padLeft(2, '0')}:${_timeFrom.minute.toString().padLeft(2, '0')}';
    }

    if (widget.initialTo != null) {
      _timeTo = widget.initialTo!;
      horaTo =
          '${_timeTo.hour.toString().padLeft(2, '0')}:${_timeTo.minute.toString().padLeft(2, '0')}';
    }

    super.initState();
  }

  void _selectTimeFrom() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _timeFrom,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (newTime != null) {
      setState(() {
        _timeFrom = newTime;
        horaFrom =
            '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';

        widget.onSelectedHourFrom(_timeFrom);
      });
    }
  }

  void _selectTimeTo() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _timeTo,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (newTime != null) {
      setState(() {
        _timeTo = newTime;
        horaTo =
            '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';

        widget.onSelectedHourTo(_timeTo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: double.infinity,
          child: CheckboxListTile(
            onChanged: widget.onCheck,
            value: widget.checkValue,
            title: Text(widget.title),
          ),
        ),
        const SizedBox(width: 10),
        if (widget.checkValue)
          size.width >= 452 ? _builWideContent() : _builNormalContent(),
      ]),
    );
  }

  Widget _builWideContent() {
    return FadeIn(
      child: Expanded(
        child: Row(children: [
          CustomInput(
              hintText: 'Abierto Desde',
              icon: Icons.timer_outlined,
              initialValue: horaFrom,
              readOnly: true,
              onTap: _selectTimeFrom),
          const SizedBox(width: 10),
          CustomInput(
            hintText: 'Abierto Hasta',
            icon: Icons.timer_outlined,
            initialValue: horaTo,
            readOnly: true,
            onTap: _selectTimeTo,
          )
        ]),
      ),
    );
  }

  Widget _builNormalContent() {
    return FadeIn(
      child: Column(children: [
        SizedBox(
            width: double.infinity,
            child: CustomInput(
                hintText: 'Abierto Desde',
                icon: Icons.timer_outlined,
                initialValue: horaFrom,
                readOnly: true,
                onTap: _selectTimeFrom)),
        const SizedBox(height: 10),
        SizedBox(
            width: double.infinity,
            child: CustomInput(
              hintText: 'Abierto Hasta',
              icon: Icons.timer_outlined,
              initialValue: horaTo,
              readOnly: true,
              onTap: _selectTimeTo,
            ))
      ]),
    );
  }
}
