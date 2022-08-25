import 'package:flutter/material.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:court_finder/models/models.dart';

class CourtCard2 extends StatelessWidget {
  const CourtCard2(this.court, {Key? key}) : super(key: key);

  final CourtModel court;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isNormalScreen = size.width > 320.0;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'court', arguments: court),
      child: Card(
        child: SizedBox(
          width: double.infinity,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              _ImageAndRating(
                imgUrl: court.imgUrl,
                rate: court.rating,
                tagId: court.id!,
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
              if (isNormalScreen) const LikeButton(),
            ]),
          ),
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
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: Colors.blueGrey,
                size: 14,
              ),
              Text(
                location,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
          Text(title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: Theme.of(context).textTheme.headline2),
          const _Facilities(),
          Row(
            children: [
              Text('Desde ', style: Theme.of(context).textTheme.bodyText1),
              Text(price, style: Theme.of(context).textTheme.bodyText1),
            ],
          )
        ],
      ),
    );
  }
}

//TODO:renombrar esto
class _Facilities extends StatelessWidget {
  const _Facilities({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final facilities = [
      IconText(
          text: 'Pasto Sintético',
          style: Theme.of(context).textTheme.subtitle2,
          icon: Icon(
            Icons.layers_outlined,
            color: Theme.of(context).primaryColor,
            size: 20,
          )),
      IconText(
          text: 'Outdoor',
          style: Theme.of(context).textTheme.subtitle2,
          icon: Icon(
            Icons.sunny,
            color: Theme.of(context).primaryColor,
            size: 20,
          ))
    ];

    final size = MediaQuery.of(context).size;
    bool isNormalScreen = size.height > 740.0;

    return isNormalScreen
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: facilities)
        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ...facilities,
            const SizedBox(
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
    required this.tagId,
  }) : super(key: key);

  final String tagId;
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
            child: Hero(
              tag: tagId,
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(imgUrl),
                fit: BoxFit.fill,
              ),
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
