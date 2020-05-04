import 'package:flutter/material.dart';
import 'package:myapp/screens/TopBar.dart';
import 'package:myapp/screens/home/InfoDay.dart';
import 'package:myapp/screens/home/ActionButton.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF281b47), Color(0xFF733178)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.57, 1.0],
            tileMode: TileMode.clamp
          ),
        ),
        child: Column(
          children: <Widget>[
            TopBar(),
            InfoDay(),
            ActionButton()
          ],
        ),
      )
    );
  }
}
