import 'package:court_finder/modules/user/models/models.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryModel category =
        ModalRoute.of(context)!.settings.arguments as CategoryModel;
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: Center(
        child: Text(category.name),
      ),
    );
  }
}
