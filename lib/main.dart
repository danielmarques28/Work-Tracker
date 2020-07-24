import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:worktracker/screens/CreateRoutine.dart';
import 'package:worktracker/screens/History.dart';
import 'package:worktracker/screens/Settings.dart';
import 'package:worktracker/screens/Home.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting();
  
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/history': (context) => History(),
      '/settings': (context) => Settings(),
      '/create-routine': (context) => CreateRoutine()
    }
  ));
}
