import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:court_finder/modules/user/controllers/ui_controller.dart';
import 'package:court_finder/modules/user/screens/screens.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    final uiCtrl = Get.put(UIController());
    uiCtrl.scaffoldKey = key;

    //Tabs pages
    const pages = [
      _Home(),
      MyBookingScreen(),
      FavoriteScreen(),
      MyProfileScreen()
    ];

    return Obx(() => Scaffold(
          resizeToAvoidBottomInset: false,
          key: key,
          drawer: const CustomDrawer(),
          body: pages[uiCtrl.currentIndexPage.value],
          bottomNavigationBar: const BottomNavbar(),
        ));
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
