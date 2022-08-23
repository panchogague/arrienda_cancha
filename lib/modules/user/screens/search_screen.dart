import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryModel category =
        ModalRoute.of(context)!.settings.arguments as CategoryModel;
    final courts = CourtModel.getPopulars();
    return Scaffold(
        appBar: AppBar(title: Text(category.name)),
        body: ListView.builder(
          itemCount: courts.length,
          itemBuilder: (_, i) => CourtCard2(courts[i]),
        ),
        bottomNavigationBar: const BottomNavbar());
  }
}
