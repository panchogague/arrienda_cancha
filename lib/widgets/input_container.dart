import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  const InputContainer(this.child, {Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  blurRadius: 5,
                  color: Colors.black.withOpacity(0.05)),
            ]),
        child: child);
  }
}
