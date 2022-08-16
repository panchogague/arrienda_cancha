import 'package:court_finder/modules/user/models/models.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopularCourts extends StatelessWidget {
  const PopularCourts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final popularCourts = CourtModel.getPopulars();
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                RichText(
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
                const Spacer(),
                const Icon(
                  FontAwesomeIcons.arrowRightLong,
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 245,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularCourts.length,
              itemBuilder: (_, int i) => CourtCard(popularCourts[i]),
            ),
          )
        ],
      ),
    );
  }
}
