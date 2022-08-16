import 'package:court_finder/modules/user/models/models.dart';
import 'package:flutter/material.dart';

class CourtScreen extends StatelessWidget {
  const CourtScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CourtModel court =
        ModalRoute.of(context)!.settings.arguments as CourtModel;
    return Scaffold(
      appBar: AppBar(title: Text(court.name)),
      body: Center(
        child: Text(court.name),
      ),
    );
  }
}
