import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CourtCard extends StatelessWidget {
  const CourtCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: 240,
        width: size.width * 0.9,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: const [
              _Image(),
              SizedBox(
                height: 16,
              ),
              _BottomSection()
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: [
          SizedBox(
            width: size.width * 0.9,
            height: 150,
            child: Image.network(
              'https://image-service.onefootball.com/transform?w=280&h=210&dpr=2&image=https%3A%2F%2Fimages.performgroup.com%2Fdi%2Flibrary%2FGOAL%2F5b%2Fef%2Fjan-breydel-stadium_jwo0464yk8s517j36es569jht.png%3Ft%3D821261326',
              fit: BoxFit.fill,
            ),
          ),
          const Positioned(
              top: 0.0,
              right: 0.0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Rating(rating: 5.0),
              )),
        ],
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  const _BottomSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Title(),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Estadio waton linares.',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: const [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.blueGrey,
                  size: 14,
                ),
                Text('Calle Aranda #34, Villa Alemana.',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            )
          ]),
    );
  }
}
