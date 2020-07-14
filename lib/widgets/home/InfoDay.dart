import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worktracker/helpers/responsive.dart';

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
    return Column(
      children: [
        Text(
          _getWeekDay(),
          style: TextStyle(
            color: Colors.white,
            fontSize: textSize(context, 32.0),
          )
        ),
        Text(
          _getDate(),
          style: TextStyle(
            color: Color(0xFFC0C2C5),
            fontSize: textSize(context, 21.0)
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
    return Container(
      margin: EdgeInsets.only(
        left: deviceWidth(context, 0.04),
        right: deviceWidth(context, 0.04)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(7.0),
          onTap: () {
            Timer(Duration(milliseconds: 200), () => widget.close?.call());
          },
          child: Container(
            padding: EdgeInsets.only(
              top: deviceHeigth(context, 0.01),
              bottom: deviceHeigth(context, 0.01)
            ),
            child: InfoColumn()
          )
        ),
      )
    );
  }
}
