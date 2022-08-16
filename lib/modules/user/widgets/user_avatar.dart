import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
      {Key? key,
      required this.imgUrl,
      this.height = 50,
      this.width = 50,
      this.showShadow = true})
      : super(key: key);

  final String imgUrl;
  final double height;
  final double width;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white60, width: 3),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            if (showShadow)
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 6,
                offset: const Offset(4, 8), // Shadow position
              ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image(fit: BoxFit.fill, image: NetworkImage(imgUrl)),
      ),
    );
  }
}
