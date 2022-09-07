import 'package:court_finder/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {Key? key,
      required this.hintText,
      required this.icon,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.onChanged,
      this.maxLine,
      required this.initialValue,
      this.onTap,
      this.readOnly = false})
      : super(key: key);

  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isPassword;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final int? maxLine;
  final String initialValue;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return InputContainer(TextField(
      controller: TextEditingController(text: initialValue),
      onChanged: onChanged,
      onTap: onTap,
      autocorrect: false,
      keyboardType: keyboardType,
      obscureText: isPassword,
      maxLines: maxLine,
      cursorHeight: 20,
      readOnly: readOnly,
      cursorColor: Theme.of(context).primaryColor,
      style: Theme.of(context).textTheme.headline4,
      decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText),
    ));
  }
}
