import 'dart:async';
import 'package:flutter/material.dart';

class RoutineCard extends StatefulWidget {
  @override
  _RoutineCardState createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  bool _getBigger = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.of(context).textScaleFactor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onLongPress: () {
          setState(() => _getBigger = true);
          Timer(Duration(seconds: 5), () => setState(() => _getBigger = false));
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: width * 0.9,
          height: height * (_getBigger ? 0.2 : 0.12),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(
            padding: EdgeInsets.only(
              left: width * 0.05,
              right: width * 0.05,
              top: height * 0.015,
              bottom: height * 0.015
            ),
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Alguma coisa'.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize * 19.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Descrição sobre essa coisa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize * 15.0,
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
