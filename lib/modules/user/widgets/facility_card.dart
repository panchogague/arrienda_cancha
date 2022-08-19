import 'package:flutter/material.dart';

class FacilityCard extends StatelessWidget {
  const FacilityCard({Key? key, required this.icon, required this.title})
      : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 68,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 6,
              offset: const Offset(4, 8), // Shadow position
            )
          ]),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(bottom: 8),
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Icon(icon),
        ),
        Text(
          title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(
          height: 8,
        )
      ]),
    );
  }
}
