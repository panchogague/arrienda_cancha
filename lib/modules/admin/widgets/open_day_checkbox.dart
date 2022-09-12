import 'package:animate_do/animate_do.dart';
import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class OpenDayCheckbox extends StatelessWidget {
  const OpenDayCheckbox(
      {Key? key,
      required this.checkValue,
      required this.onCheck,
      required this.title,
      required this.initialFrom,
      required this.initialTo,
      this.onConfirmFrom,
      this.onConfirmTo})
      : super(key: key);
  final bool checkValue;
  final Function(bool?) onCheck;
  final String title;
  final String initialFrom;
  final String initialTo;
  final Function(Picker, List<int>)? onConfirmFrom;
  final Function(Picker, List<int>)? onConfirmTo;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: double.infinity,
          child: CheckboxListTile(
            onChanged: onCheck,
            value: checkValue,
            title: Text(title),
          ),
        ),
        const SizedBox(width: 10),
        if (checkValue)
          size.width >= 452 ? _builWideContent() : _builNormalContent(),
      ]),
    );
  }

  Widget _builWideContent() {
    return FadeIn(
      child: Row(children: [
        Expanded(
          child: CustomTimepicker(
            hintText: 'Abierto Desde',
            initialvalue: initialFrom,
            onConfirm: onConfirmFrom,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTimepicker(
            hintText: 'Abierto Hasta',
            initialvalue: initialTo,
            onConfirm: onConfirmTo,
          ),
        )
      ]),
    );
  }

  Widget _builNormalContent() {
    return FadeIn(
      child: Column(children: [
        SizedBox(
            width: double.infinity,
            child: CustomTimepicker(
              hintText: 'Abierto Desde',
              initialvalue: initialFrom,
              onConfirm: onConfirmFrom,
            )),
        const SizedBox(height: 10),
        SizedBox(
            width: double.infinity,
            child: CustomTimepicker(
              hintText: 'Abierto Hasta',
              initialvalue: initialTo,
              onConfirm: onConfirmTo,
            ))
      ]),
    );
  }
}
