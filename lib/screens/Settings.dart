import 'package:flutter/material.dart';
import 'package:worktracker/widgets/background.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: background(),
        child: Container(
          child: Text('settings'),
        )
      )
    );
  }
}
