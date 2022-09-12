import 'package:court_finder/helpers/format_helper.dart';
import 'package:court_finder/modules/admin/providers/providers.dart';
import 'package:court_finder/modules/admin/widgets/widgets.dart';
import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CourtForm extends StatelessWidget {
  const CourtForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courtForm = Provider.of<CourtProfileProvider>(context);
    return Form(
      key: courtForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Flexible(
                  child: CustomInput(
                initialValue: courtForm.court.name,
                onChanged: (value) => courtForm.court.name = value,
                hintText: 'Nombre del recinto',
                icon: FontAwesomeIcons.addressCard,
              )),
              const SizedBox(width: 20),
              Flexible(
                child: CustomInput(
                  initialValue: courtForm.court.location,
                  onChanged: (value) => courtForm.court.location = value,
                  hintText: 'Ubicación',
                  icon: Icons.location_on_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Flexible(
                child: CustomInput(
                  initialValue: courtForm.court.howToAccess,
                  onChanged: (value) => courtForm.court.howToAccess = value,
                  keyboardType: TextInputType.multiline,
                  maxLine: 5,
                  hintText: 'Cómo llegar',
                  icon: FontAwesomeIcons.key,
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: CustomInput(
                  initialValue: courtForm.court.cancellationPolicy,
                  onChanged: (value) =>
                      courtForm.court.cancellationPolicy = value,
                  keyboardType: TextInputType.multiline,
                  maxLine: 5,
                  hintText: 'Política de cancelación',
                  icon: Icons.cancel_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          CustomInput(
            initialValue: courtForm.court.description,
            onChanged: (value) => courtForm.court.description = value,
            keyboardType: TextInputType.multiline,
            maxLine: 5,
            hintText: 'Descripción del recinto',
            icon: Icons.description_outlined,
          ),
          const SizedBox(height: 30),
          const _SelectArea(),
        ],
      ),
    );
  }
}

class _SelectArea extends StatelessWidget {
  const _SelectArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return (size.width > 894.0)
        ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Expanded(child: _OpenDays()),
            SizedBox(width: 30),
            Expanded(child: _Facilities())
          ])
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [_OpenDays(), SizedBox(height: 10), _Facilities()]);
  }
}

class _OpenDays extends StatelessWidget {
  const _OpenDays({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courtForm = Provider.of<CourtProfileProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff264653).withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Días abiertos'),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            itemCount: courtForm.daysOfWeeks.length,
            itemBuilder: (_, i) => OpenDayCheckbox(
              title: courtForm.daysOfWeeks[i].name,
              checkValue: courtForm.daysOfWeeks[i].value,
              initialFrom: courtForm.daysOfWeeks[i].from,
              initialTo: courtForm.daysOfWeeks[i].to,
              onCheck: (value) => courtForm.checkDaysOfWeek(i),
              onConfirmFrom: (Picker picker, List value) {
                DateTime? datePicked =
                    (picker.adapter as DateTimePickerAdapter).value;
                if (datePicked != null) {
                  int hour = datePicked.hour;
                  int minutes = datePicked.minute;
                  courtForm.setHourDaysOfWeek(
                      i, FormatHelper.convertTime(hour, minutes), null);
                }
              },
              onConfirmTo: (Picker picker, List value) {
                DateTime? datePicked =
                    (picker.adapter as DateTimePickerAdapter).value;
                if (datePicked != null) {
                  int hour = datePicked.hour;
                  int minutes = datePicked.minute;
                  courtForm.setHourDaysOfWeek(
                      i, null, FormatHelper.convertTime(hour, minutes));
                }
              },
            ),
            separatorBuilder: (_, __) => const Divider(),
          )
        ],
      ),
    );
  }
}

class _Facilities extends StatelessWidget {
  const _Facilities({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courtForm = Provider.of<CourtProfileProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff264653).withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Facilidades'),
          const SizedBox(height: 10),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: courtForm.facilities.length,
            itemBuilder: (_, i) => CheckboxListTile(
              title: Text(courtForm.facilities[i].name),
              value: courtForm.facilities[i].value,
              onChanged: (value) => courtForm.checkFacilities(value!, i),
            ),
          ),
        ],
      ),
    );
  }
}
