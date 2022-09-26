import 'package:court_finder/controllers/court_controller.dart';
import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:court_finder/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryModel category =
        ModalRoute.of(context)!.settings.arguments as CategoryModel;

    final courtCtrl = Get.find<CourtController>();

    return Obx(() => Scaffold(
        appBar: AppBar(title: Text(category.name)),
        body: courtCtrl.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : ListView.builder(
                itemCount: courtCtrl.courtsCategory.length,
                itemBuilder: (_, i) => CourtCard2(courtCtrl.courtsCategory[i]),
              ),
        bottomNavigationBar: const BottomNavbar()));
  }
}
