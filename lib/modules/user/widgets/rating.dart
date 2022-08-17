import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating(
      {Key? key,
      required this.rating,
      this.radius = 40,
      this.width = 62,
      this.height = 28,
      this.showShadow = false})
      : super(key: key);

  final double rating;
  final double radius;
  final double width;
  final double height;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            if (showShadow)
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 6,
                offset: const Offset(4, 8), // Shadow position
              ),
          ]),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 18,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
        )
      ]),
    );
  }
}
