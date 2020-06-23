import 'package:flutter/material.dart';
import 'package:worktracker/screens/Home.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting();
  
  runApp(MaterialApp(home: Home()));
}
