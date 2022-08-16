import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PopularCourts extends StatelessWidget {
  const PopularCourts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: RichText(
              text: const TextSpan(
                text: 'Canchas ',
                style: TextStyle(fontSize: 18, color: Colors.black87),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Populares',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          CourtCard()
        ],
      ),
    );
  }
}
