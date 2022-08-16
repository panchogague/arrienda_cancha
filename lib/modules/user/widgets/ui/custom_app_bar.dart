import 'package:court_finder/modules/user/widgets/widgets.dart';
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
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
            const UserAvatar(
              imgUrl:
                  'https://www.eaglesvine.com/wp-content/uploads/2021/06/Gabbie-Carter_05.jpg',
            )
          ]),
        ),
      ),
    );
  }
}
