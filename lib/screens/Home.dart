import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worktracker/widgets/home/ListCards.dart';
import 'package:worktracker/widgets/home/TopBar.dart';
import 'package:worktracker/widgets/home/InfoDay.dart';
import 'package:worktracker/widgets/home/DayGraph.dart';
import 'package:worktracker/widgets/background.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: background(),
        child: ListView(
          shrinkWrap: true,
          children: [
            TopBar(),
            InfoDay(),
            DayGraph(),
            ListCards()
          ]
        )
      )
    );
  }
}
