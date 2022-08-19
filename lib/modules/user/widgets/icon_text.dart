import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    Key? key,
    required this.text,
    required this.icon,
    this.style,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 5),
        Text(
          text,
          style: style,
        ),
      ],
    );
  }
}
