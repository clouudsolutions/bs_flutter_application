import 'package:bs_flutter_application/Screens/Country.dart';
import 'package:bs_flutter_application/Screens/CountryMap.dart';
import 'package:bs_flutter_application/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'Screens/AllCountries.dart';
void main() {
  runApp(MaterialApp(
    home: Home(),
    routes: {
      'allCountries' : (ctx) => AllCountries(),
      CountryMap.routeName: (ctx) => CountryMap(),
      Country.routeName: (ctx)=> Country(),
    },
  ));
}
