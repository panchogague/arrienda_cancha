import 'package:court_finder/modules/user/models/models.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CourtCard extends StatelessWidget {
  const CourtCard(this.court, {Key? key}) : super(key: key);

  final CourtModel court;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'court', arguments: court),
      child: SizedBox(
        height: 245,
        width: size.width * 0.95,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              _Image(
                urlImg: court.imgUrl,
                rating: court.rating,
                tagId: court.id,
              ),
              const SizedBox(
                height: 2,
              ),
              _BottomSection(
                title: court.name,
                location: court.location,
              ),
              const SizedBox(
                height: 5,
              ),
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
    required this.urlImg,
    required this.rating,
    required this.tagId,
  }) : super(key: key);

  final String urlImg;
  final double? rating;
  final String tagId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: [
          SizedBox(
            width: size.width * 0.95,
            height: 150,
            child: Hero(
              tag: tagId,
              child: FadeInImage(
                image: NetworkImage(urlImg),
                fit: BoxFit.fill,
                placeholder: const AssetImage('assets/loading.gif'),
              ),
            ),
          ),
          if (rating != null)
            Positioned(
                top: 0.0,
                right: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Rating(rating: rating!),
                )),
        ],
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  const _BottomSection({
    Key? key,
    required this.title,
    required this.location,
  }) : super(key: key);

  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double sizeAvatar = 40.0;
    double commentSize = 10.0;

    if (size.height < 740.0) {
      sizeAvatar = 25.0;
      commentSize = 8.0;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Title(title: title, location: location),
        const Spacer(),
        Column(
          children: [
            Row(
              children: [
                Align(
                  widthFactor: 0.6,
                  child: UserAvatar(
                      width: sizeAvatar,
                      height: sizeAvatar,
                      showShadow: false,
                      imgUrl:
                          'https://financerewind.com/wp-content/uploads/2022/06/sasha-grey-5.webp'),
                ),
                Align(
                  widthFactor: 0.6,
                  child: UserAvatar(
                      width: sizeAvatar,
                      height: sizeAvatar,
                      showShadow: false,
                      imgUrl:
                          'https://www.eaglesvine.com/wp-content/uploads/2021/06/Gabbie-Carter_05.jpg'),
                ),
                Align(
                  widthFactor: 0.6,
                  child: UserAvatar(
                      width: sizeAvatar,
                      height: sizeAvatar,
                      showShadow: false,
                      imgUrl:
                          'https://www.meme-arsenal.com/memes/818dab40d4bfe8f9f602852e5ddfbc09.jpg'),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(children: [
                const Text(
                  '+27',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text('Comentarios',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.blueGrey, fontSize: commentSize))
              ]),
            )
          ],
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.title,
    required this.location,
  }) : super(key: key);

  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blueGrey,
                  size: 14,
                ),
                Text(location,
                    style:
                        const TextStyle(color: Colors.blueGrey, fontSize: 12)),
              ],
            )
          ]),
    );
  }
}
