import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:court_finder/modules/user/screens/screens.dart';
import 'package:court_finder/modules/user/providers/ui_provider.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    final uiProvider = Provider.of<UIProvider>(context);
    uiProvider.scaffoldKey = key;

    //Tabs pages
    const pages = [
      _Home(),
      MyBookingScreen(),
      FavoriteScreen(),
      MyProfileScreen()
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: key,
      drawer: const CustomDrawer(),
      body: pages[uiProvider.currentIndexPage],
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
