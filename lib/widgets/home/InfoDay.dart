import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        top: height * 0.07,
        left: width * 0.05,
        right: width * 0.05,
      ),
      child: Center(
        child: Container(
          child: InfoColumn(),
        )
      )
    );
  }
}

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
      children: <Widget>[
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

class WelcomeUser extends StatelessWidget {
  _decideWelcome() {
    DateTime datetime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Bom'),
    );
  }
}
