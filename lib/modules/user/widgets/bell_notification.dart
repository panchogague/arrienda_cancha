import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BellNotification extends StatelessWidget {
  const BellNotification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(
          CupertinoIcons.bell_fill,
          color: Colors.black54,
          size: 20,
        ),
        Positioned(
          top: 0,
          right: 0.0,
          child: Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}
