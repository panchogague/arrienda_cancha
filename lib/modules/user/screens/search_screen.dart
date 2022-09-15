import 'package:court_finder/models/models.dart';
import 'package:court_finder/modules/user/widgets/widgets.dart';
import 'package:court_finder/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryModel category =
        ModalRoute.of(context)!.settings.arguments as CategoryModel;

    final courtService = Provider.of<CourtService>(context);

    return Scaffold(
        appBar: AppBar(title: Text(category.name)),
        body: courtService.isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : ListView.builder(
                itemCount: courtService.courtsCategory.length,
                itemBuilder: (_, i) =>
                    CourtCard2(courtService.courtsCategory[i]),
              ),
        bottomNavigationBar: const BottomNavbar());
  }
}
