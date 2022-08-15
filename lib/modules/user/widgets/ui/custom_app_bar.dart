import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        height: 60,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Icon(FontAwesomeIcons.bars),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.blueGrey,
                  ),
                  Text(
                    'Villa Alemana, Valparaíso.',
                    style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                  )
                ]),
            _Avatar()
          ]),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white60, width: 2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 6,
              offset: const Offset(4, 8), // Shadow position
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: const Image(
            fit: BoxFit.fill,
            image: NetworkImage(
                'https://www.eaglesvine.com/wp-content/uploads/2021/06/Gabbie-Carter_05.jpg')),
      ),
    );
  }
}
