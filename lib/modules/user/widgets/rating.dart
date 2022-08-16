import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating(
      {Key? key,
      required this.rating,
      this.radius = 40,
      this.width = 62,
      this.height = 28})
      : super(key: key);

  final double rating;
  final double radius;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(radius)),
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
