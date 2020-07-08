import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worktracker/models/CalendarFile.dart';
import 'package:worktracker/widgets/home/CarouselDay.dart';
import 'package:worktracker/widgets/home/InfoDay.dart';
import 'package:worktracker/widgets/home/ListCards.dart';
import 'package:worktracker/widgets/home/TopBar.dart';
import 'package:worktracker/widgets/home/DayGraph.dart';
import 'package:worktracker/widgets/background.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> calendar;
  bool showCarousel = false;
  String date = DateTime.now().toString().substring(0, 10);

  @override
  void initState() {
    super.initState();
    CalendarFile().readFile().then((value) {
      setState(() {
        calendar = value;
      });
    });
  }

  Widget _swapContainer() {
    return showCarousel ?
      CarouselDay(callback: (value) {
        setState(() {
          date = value;
        });
      })
      :
      InfoDay(callback: (value) {
        setState(() {
          showCarousel = value;
        });
      });
  }

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
            _swapContainer(),
            DayGraph(),
            ListCards()
          ]
        )
      )
    );
  }
}
