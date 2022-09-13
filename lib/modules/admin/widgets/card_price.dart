import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CardPrice extends StatelessWidget {
  const CardPrice(
      {Key? key,
      required this.title,
      required this.switchValue,
      this.onSwitchChanged,
      required this.fromValue,
      required this.toValue,
      this.onConfirmFrom,
      this.onConfirmTo,
      required this.priceValue,
      this.onPriceChanged,
      required this.items,
      required this.onConfirmDays,
      required this.initialValueDays})
      : super(key: key);

  final String title;
  final bool switchValue;
  final Function(bool)? onSwitchChanged;
  final String fromValue;
  final String toValue;
  final Function(Picker, List<int>)? onConfirmFrom;
  final Function(Picker, List<int>)? onConfirmTo;
  final String priceValue;
  final Function(String)? onPriceChanged;
  final List<String> items;
  final Function(List<String>) onConfirmDays;
  final List<String> initialValueDays;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87)),
            const Spacer(),
            Switch(
                activeColor: Theme.of(context).primaryColor,
                value: switchValue,
                onChanged: onSwitchChanged)
          ]),
          const Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: CustomTimepicker(
                  hintText: 'Desde',
                  initialvalue: fromValue,
                  onConfirm: onConfirmFrom),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: CustomTimepicker(
                  hintText: 'Hasta',
                  initialvalue: toValue,
                  onConfirm: onConfirmTo),
            )
          ]),
          const SizedBox(height: 10),
          InputContainer(
            MultiSelectDialogField(
              buttonText: Text('Días aplicables',
                  style: Theme.of(context).textTheme.headline4),
              buttonIcon: Icon(Icons.calendar_today_rounded,
                  color: Theme.of(context).primaryColor),
              items: items.map((e) => MultiSelectItem(e, e)).toList(),
              initialValue: initialValueDays,
              listType: MultiSelectListType.CHIP,
              cancelText:
                  const Text('Cancelar', style: TextStyle(color: Colors.red)),
              onConfirm: onConfirmDays,
            ),
          ),
          const SizedBox(height: 10),
          CustomInput(
            initialValue: priceValue,
            onChanged: onPriceChanged,
            keyboardType: TextInputType.number,
            hintText: 'Precio',
            icon: Icons.attach_money_outlined,
          )
        ]),
      ),
    );
  }
}
