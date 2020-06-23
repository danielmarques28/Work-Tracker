import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoDay extends StatefulWidget {
  @override
  _InfoDayState createState() => _InfoDayState();
}

class _InfoDayState extends State<InfoDay> {
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
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(
          children: <Widget>[
            Text(
              _getWeekDay(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
              )
            ),
            Text(
              _getDate(),
              style: TextStyle(
                color: Color(0xFFC0C2C5),
                fontSize: 21.0
              )
            ),
          ],
        ),
        )
      )
    );
  }
}
