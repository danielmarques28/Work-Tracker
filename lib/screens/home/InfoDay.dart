import 'package:flutter/material.dart';

class InfoDay extends StatefulWidget {
  @override
  _InfoDayState createState() => _InfoDayState();
}

class _InfoDayState extends State<InfoDay> {
  _getWeekDay() {
    var dateTime = DateTime.now();
    int weekDayNumber = dateTime.weekday;
    var weekDays = ['Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado', 'Domingo'];

    String weekDay = weekDays[weekDayNumber - 1];

    return weekDay.toUpperCase();
  }

  _getDate() {
    var dateTime = DateTime.now();
    int day = dateTime.day;
    int monthNumber = dateTime.month;
    var months = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];

    String month = months[monthNumber -1];

    return '$day, $month';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.11,
          child: Column(
          children: <Widget>[
            Text(
              _getWeekDay(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold
              )
            ),
            Text(
              _getDate(),
              style: TextStyle(
                color: Color(0xFFC0C2C5),
                fontSize: 22.0
              )
            ),
          ],
        ),
        )
      )
    );
  }
}
