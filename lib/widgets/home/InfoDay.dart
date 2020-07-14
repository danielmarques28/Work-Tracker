import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoColumn extends StatelessWidget {
  _getWeekDay() {
    DateTime dateTimeNow = DateTime.now();
    String weekDay = DateFormat.EEEE().format(dateTimeNow);

    return weekDay.toUpperCase();
  }

  _getDate() {
    DateTime dateTimeNow = DateTime.now();
    String dateString = DateFormat.yMMMMd().format(dateTimeNow);

    return dateString;
  }

  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).textScaleFactor;

    return Column(
      children: [
        Text(
          _getWeekDay(),
          style: TextStyle(
            color: Colors.white,
            fontSize: textSize * 32.0,
          )
        ),
        Text(
          _getDate(),
          style: TextStyle(
            color: Color(0xFFC0C2C5),
            fontSize: textSize * 21.0
          )
        ),
      ],
    );
  }
}

class InfoDay extends StatefulWidget {
  final Function close;

  InfoDay({Key key, @required this.close}) : super(key : key);

  @override
  _InfoDayState createState() => _InfoDayState();
}

class _InfoDayState extends State<InfoDay> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        left: width * 0.04,
        right: width * 0.04
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(7.0),
          onTap: () {
            Timer(Duration(milliseconds: 200), () => widget.close?.call());
          },
          child: Container(
            padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.01),
            child: InfoColumn()
          )
        ),
      )
    );
  }
}
