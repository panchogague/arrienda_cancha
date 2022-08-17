import 'package:court_finder/modules/user/models/models.dart';
import 'package:court_finder/modules/user/widgets/rating.dart';
import 'package:court_finder/theme/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CourtCard2 extends StatelessWidget {
  const CourtCard2(this.court, {Key? key}) : super(key: key);

  final CourtModel court;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isNormalScreen = size.height > 740.0;
    return Card(
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            _ImageAndRating(
              imgUrl: court.imgUrl,
              rate: court.rating,
            ),
            const SizedBox(
              width: 10,
            ),
            _Content(
              title: court.name,
              location: court.location,
              price: court.price,
            ),
            const Spacer(),
            if (isNormalScreen)
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.heart,
                    color: Colors.grey,
                  )),
          ]),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.title,
    required this.location,
    required this.price,
  }) : super(key: key);

  final String title;
  final String location;
  final String price;

  //TODO:agregar facilities

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: CustomTheme.subTitle,
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(
                  color: CustomTheme.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          const _Facilities(),
          Text(price,
              style: const TextStyle(
                  color: CustomTheme.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16))
        ],
      ),
    );
  }
}

class _Facilities extends StatelessWidget {
  const _Facilities({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const facilities = [
      Icon(
        Icons.layers_outlined,
        color: CustomTheme.iconColor,
        size: 20,
      ),
      Text('Pasto Sintético',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: CustomTheme.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12)),
      SizedBox(
        width: 5,
      ),
      Icon(
        Icons.sunny,
        color: CustomTheme.iconColor,
        size: 20,
      ),
      Text('Outdoor',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: CustomTheme.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12)),
    ];

    final size = MediaQuery.of(context).size;
    bool isNormalScreen = size.height > 740.0;

    return isNormalScreen
        ? Row(children: facilities)
        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            ...facilities,
            SizedBox(
              height: 3,
            )
          ]);
  }
}

class _ImageAndRating extends StatelessWidget {
  const _ImageAndRating({
    Key? key,
    required this.imgUrl,
    required this.rate,
  }) : super(key: key);

  final String imgUrl;
  final double? rate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          width: 110,
          height: 160,
        ),
        Container(
          width: 110,
          height: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(imgUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        if (rate != null)
          Positioned.fill(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Rating(
                  rating: rate!,
                  showShadow: true,
                )),
          )
      ],
    );
  }
}
