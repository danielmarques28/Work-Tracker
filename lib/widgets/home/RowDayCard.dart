import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:worktracker/helpers/responsive.dart';
import 'package:worktracker/widgets/home/DayCard.dart';

class RowDayCard extends StatefulWidget {
  final Function updateSelectedDate;
  final Function close;

  RowDayCard({
    Key key,
    @required this.updateSelectedDate,
    @required this.close
  }) : super(key: key);

  @override
  RowDayCardState createState() => RowDayCardState();
}

class RowDayCardState extends State<RowDayCard> {
  List<dynamic> _days;
  int _activeIndex = 0;
  Timer _countdown;

  @override
  void initState() {
    super.initState();
    _generateDaysList();
    startCountdown();
  }

  void _generateDaysList() {
    List<dynamic> items = List.generate(7, (index) {
      final DateTime dateTimeNow
        = DateTime.now().add(Duration(days: -index));
      final String weekday = DateFormat.EEEE().format(dateTimeNow);
      final Object day = {
        'date': dateTimeNow,
        'day': dateTimeNow.day.toString(),
        'weekday': weekday.substring(0, 3).toUpperCase()
      };

      return day;
    });

    setState(() {
      _days = items;
    });
  }

  void startCountdown() {
    setState(() {
      _countdown = Timer(Duration(seconds: 5), () => widget.close?.call());
    });
  }

  void _restartCountdown() {
    _countdown.cancel();
    startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if(notification != null)
          _restartCountdown();
        return true;
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 10.0,
          left: deviceWidth(context, 0.04),
          right: deviceWidth(context, 0.04)
        ),
        height: 72.0,
        child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _days.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(7.0),
                  onTap: () {
                    setState(() {
                      _activeIndex = index;
                    });
                    final String date = _days[index]['date']
                      .toString()
                      .substring(0, 10);
                    widget.updateSelectedDate(date);
                  },
                  child: DayCard(
                    active: index == _activeIndex,
                    day: _days[index]
                  )
                ),
                Container(width: deviceWidth(context, index > 0 ? 0.02 : 0))
              ]
            );
          }
        )
      )
    );
  }
}
