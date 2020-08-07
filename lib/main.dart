import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:worktracker/screens/CreateRoutine.dart';
import 'package:worktracker/screens/History.dart';
import 'package:worktracker/screens/Settings.dart';
import 'package:worktracker/screens/Home.dart';

Map<String, Widget Function(BuildContext)> getRoutes() {
  return {
    '/': (context) => Home(),
    '/history': (context) => History(),
    '/settings': (context) => Settings(),
    '/create-routine': (context) => CreateRoutine()
  };
}

ThemeData getThemeData() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF1A4F95),
    accentColor: Color(0xFFEA4A64),
    backgroundColor: Color(0xFF1F253D),
    splashColor: Colors.white24,
    cardColor: Colors.black26,
    scaffoldBackgroundColor: Color(0xFF1F253D)
  );
}

void main() {
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting();
  
  runApp(MaterialApp(
    theme: getThemeData(),
    initialRoute: '/',
    routes: getRoutes()
  ));
}
