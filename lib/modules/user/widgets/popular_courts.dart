import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';

class PopularCourts extends StatelessWidget {
  const PopularCourts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final popularCourts = [];
    // CourtModel.getPopulars();
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
                  text: TextSpan(
                    text: 'Canchas ',
                    style: Theme.of(context).textTheme.headline3,
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Populares',
                          style: Theme.of(context).textTheme.headline2),
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
            height: 250,
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
