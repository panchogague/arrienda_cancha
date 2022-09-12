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
            hideHeader: true,
            adapter: DateTimePickerAdapter(
                type: PickerDateTimeType.kHM_AP, value: selectedValue),
            title: Text("Seleccione Hora"),
            selectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
            onConfirm: onConfirm)
        .showDialog(context);
  }

  showPickerDateRange(BuildContext context) {
    print("canceltext: ${PickerLocalizations.of(context).cancelText}");

    Picker ps = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kHM_AP,
        ),
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).value);
        });

    Picker pe = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(type: PickerDateTimeType.kHM_AP),
        onConfirm: (Picker picker, List value) {
          print((picker.adapter as DateTimePickerAdapter).value);
        });

    List<Widget> actions = [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar')),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            ps.onConfirm?.call(ps, ps.selecteds);
            pe.onConfirm?.call(pe, pe.selecteds);
          },
          child: const Text('Confirmar'))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Hora"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Desde:"),
                  ps.makePicker(),
                  Text("Hasta:"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }
}
