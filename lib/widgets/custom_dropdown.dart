import 'package:court_finder/models/models.dart';
import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.items,
    this.onChanged,
  }) : super(key: key);
  final String hintText;
  final IconData icon;
  final List<DropdownMenuItem<DropdownValueModel>> items;
  final Function(DropdownValueModel?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InputContainer(DropdownButtonFormField<DropdownValueModel>(
        decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
            focusedBorder: InputBorder.none,
            border: InputBorder.none),
        hint: Text(hintText),
        style: Theme.of(context).textTheme.headline4,
        items: items,
        onChanged: onChanged));
  }
}
