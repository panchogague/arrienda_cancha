import 'package:court_finder/modules/admin/models/models.dart';
import 'package:court_finder/services/services.dart';
import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class CardPrice extends StatelessWidget {
  const CardPrice({
    Key? key,
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
    required this.initialValueDays,
  }) : super(key: key);

  final String title;
  final bool switchValue;
  final Function(bool)? onSwitchChanged;
  final String fromValue;
  final String toValue;
  final Function(Picker, List<int>)? onConfirmFrom;
  final Function(Picker, List<int>)? onConfirmTo;
  final String priceValue;
  final Function(String)? onPriceChanged;
  final List<CheckboxValueModel> items;
  final Function(List<CheckboxValueModel>) onConfirmDays;
  final List<CheckboxValueModel> initialValueDays;

  @override
  Widget build(BuildContext context) {
    final courtProvider = Provider.of<CourtService>(context, listen: false);
    List<String> dias = ['Todos los días'];
    if (courtProvider.court != null) {
      if (courtProvider.court!.openDays != null) {
        dias.addAll(
            courtProvider.court!.openDays!.map((e) => e.dayName).toList());
      }
    }

    return Card(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
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
                items: items.map((e) => MultiSelectItem(e, e.name)).toList(),
                initialValue: initialValueDays,
                listType: MultiSelectListType.CHIP,
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
        ));
  }
}
