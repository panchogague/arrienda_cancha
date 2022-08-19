import 'package:court_finder/modules/user/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';

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
            IconButton(
                onPressed: () {
                  final key = Provider.of<UIProvider>(context, listen: false)
                      .scaffoldKey;
                  key!.currentState!.openDrawer();
                },
                icon: const Icon(FontAwesomeIcons.bars)),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: Colors.blueGrey,
              ),
              Text(
                'Villa Alemana, Valparaíso.',
                style: Theme.of(context).textTheme.subtitle1,
              )
            ]),
            SizedBox(
              width: 45,
              height: 45,
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () {},
                backgroundColor: Colors.transparent,
                child: const BellNotification(),
              ),
            )

            // const UserAvatar(
            //   imgUrl:
            //       'https://www.eaglesvine.com/wp-content/uploads/2021/06/Gabbie-Carter_05.jpg',
            // )
          ]),
        ),
      ),
    );
  }
}
