import 'dart:async';
import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';

class RoutineCard extends StatefulWidget {
  RoutineCard({Key key, @required this.routine});

  final Map<String, dynamic> routine;

  @override
  _RoutineCardState createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  bool _getBigger = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onLongPress: () {
          setState(() => _getBigger = true);
          Timer(
            Duration(seconds: 5),
            () => setState(() => _getBigger = false)
          );
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: deviceWidth(context, 0.9),
          height: deviceHeigth(context, _getBigger ? 0.2 : 0.12),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(
            padding: EdgeInsets.only(
              left: deviceWidth(context, 0.05),
              right: deviceWidth(context, 0.05),
              top: deviceHeigth(context, 0.015),
              bottom: deviceHeigth(context, 0.015)
            ),
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Rotina ${widget.routine['routine_id']} - ${widget.routine['status']}'
                      .toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize(context, 19.0),
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Descrição sobre essa rotina',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize(context, 15.0),
                    )
                  )
                )
              ],
            )
          )
        )
      )
    );
  }
}
