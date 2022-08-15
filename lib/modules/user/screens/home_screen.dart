import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundCurve(),
          Column(
            children: const [
              CustomAppBar(),
              SizedBox(
                height: 30,
              ),
              CustomSearchBar(),
              SizedBox(
                height: 20,
              ),
              Categories(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
