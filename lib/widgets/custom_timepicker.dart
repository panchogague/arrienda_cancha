import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

class CustomTimepicker extends StatelessWidget {
  const CustomTimepicker(
      {Key? key,
      required this.hintText,
      required this.initialvalue,
      this.onConfirm})
      : super(key: key);

  final String hintText;
  final String initialvalue;
  final Function(Picker, List<int>)? onConfirm;

  DateTime? get selectedValue {
    if (initialvalue.isEmpty) {
      return null;
    }
    final hourMinutes = initialvalue.split(':');
    DateTime dateSelected = DateTime.now();
    return DateTime(dateSelected.year, dateSelected.month, dateSelected.day,
        int.parse(hourMinutes[0]), int.parse(hourMinutes[1]), 0);
  }

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      hintText: hintText,
      icon: Icons.watch_later_outlined,
      initialValue: initialvalue,
      readOnly: true,
      onTap: () {
        showPickerDate(context);
      },
    );
  }

  showPickerDate(BuildContext context) {
    Picker(
            cancelText: 'Cancelar',
            cancelTextStyle: const TextStyle(color: Colors.red),
            confirmText: 'OK',
            confirmTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            hideHeader: true,
            adapter: DateTimePickerAdapter(
                type: PickerDateTimeType.kHM_AP, value: selectedValue),
            title: const Text("Seleccione Hora"),
            selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            onConfirm: onConfirm)
        .showDialog(context);
  }
}
