import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:court_finder/modules/user/widgets/rating.dart';

class ImageAppBar extends StatelessWidget {
  const ImageAppBar(
      {Key? key, required this.imgUrl, required this.tag, this.rating})
      : super(key: key);

  final String imgUrl;
  final String tag;
  final double? rating;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Hero(
            tag: tag,
            child: FadeInImage(
                image: NetworkImage(imgUrl),
                placeholder: const AssetImage('assets/loading.gif'),
                fit: BoxFit.fill),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black26),
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          FontAwesomeIcons.arrowLeftLong,
                          size: 18,
                          color: Colors.white,
                        )),
                  ),
                  const Spacer(),
                  if (rating != null)
                    Container(
                      width: 60,
                      height: 36,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white70),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26),
                      child: Rating(
                        rating: rating!,
                        radius: 10,
                        color: Colors.black26,
                        textColor: Colors.white,
                      ),
                    ),
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white70),
                        shape: BoxShape.circle,
                        color: Colors.black26),
                    child: const LikeButton(color: Colors.white70),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
