import 'package:court_finder/modules/user/providers/ui_provider.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = Provider.of<UIProvider>(context).scaffoldKey;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: key,
      drawer: Drawer(),
      body: Stack(
        children: [
          const BackgroundCurve(),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
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
                SizedBox(
                  height: 20,
                ),
                PopularCourts()
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
