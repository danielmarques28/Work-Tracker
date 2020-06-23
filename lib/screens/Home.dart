import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worktracker/widgets/home/TopBar.dart';
import 'package:worktracker/widgets/home/InfoDay.dart';
import 'package:worktracker/widgets/home/ActionButton.dart';
import 'package:worktracker/widgets/home/BottomBar.dart';
import 'package:worktracker/widgets/background.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: background(),
        child: Column(
          children: <Widget>[
            TopBar(),
            InfoDay(),
            ActionButton(),
            BottomBar()
          ]
        )
      )
    );
  }
}
