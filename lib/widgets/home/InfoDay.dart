import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:worktracker/helpers/responsive.dart';

class InfoColumn extends StatelessWidget {
  InfoColumn({@required this.selectedDate});

  final String selectedDate;

  _getWeekDay() {
    DateTime dateTime = DateTime.parse(selectedDate);
    String weekDay = DateFormat.EEEE().format(dateTime);

    return weekDay.toUpperCase();
  }

  _getDate() {
    DateTime dateTime = DateTime.parse(selectedDate);
    String dateString = DateFormat.yMMMMd().format(dateTime);

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
            fontSize: textSize(context, 30.0),
          )
        ),
        Text(
          _getDate(),
          style: TextStyle(
            color: Color(0xFFC0C2C5),
            fontSize: textSize(context, 19.0)
          )
        )
      ]
    );
  }
}

class InfoDay extends StatefulWidget {
  InfoDay({
    Key key,
    @required this.close,
    @required this.selectedDate
  }) : super(key : key);

  final Function close;
  final String selectedDate;

  @override
  InfoDayState createState() => InfoDayState();
}

class InfoDayState extends State<InfoDay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(7.0),
          onTap: () {
            Timer(
              Duration(milliseconds: 150),
              () => widget.close?.call()
            );
          },
          child: Container(
            height: 72.0,
            width: deviceWidth(context, 0.95),
            padding: EdgeInsets.only(
              top: 6.0,
              bottom: 6.0
            ),
            child: InfoColumn(selectedDate: widget.selectedDate)
          )
        ),
      )
    );
  }
}
