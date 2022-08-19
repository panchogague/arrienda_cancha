import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key, this.color = Colors.grey}) : super(key: key);

  final Color color;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            liked = !liked;
          });
        },
        icon: liked
            ? const Icon(
                CupertinoIcons.heart_fill,
                color: Colors.red,
              )
            : const Icon(
                CupertinoIcons.heart,
                color: Colors.grey,
              ));
  }
}
