import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FacilityModel {
  String name;
  IconData icon;

  FacilityModel({required this.name, required this.icon});

  static List<FacilityModel> getAllFacilities() {
    return [
      FacilityModel(
        name: 'Baños',
        icon: FontAwesomeIcons.toilet,
      ),
      FacilityModel(
        name: 'Duchas',
        icon: Icons.shower,
      ),
      FacilityModel(
        name: 'Kiosco',
        icon: FontAwesomeIcons.shop,
      ),
      FacilityModel(
        name: 'Accesso',
        icon: FontAwesomeIcons.wheelchair,
      )
    ];
  }
}
