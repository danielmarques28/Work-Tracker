import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.of(context).textScaleFactor;

    return Container(
      padding: EdgeInsets.only(top: height * 0.03, bottom: height * 0.03),
      width: width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white24,
        // borderRadius: BorderRadius.circular(40.0)
      ),
      child: Container(
        padding: EdgeInsets.only(left: width * 0.08),
        width: width * 0.6,
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Meditar',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize * 20.0,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            SizedBox(height: 3),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fazer por 5 minutos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize * 15.0,
                )
              )
            )
          ],
        )
      )
    );
  }
}
