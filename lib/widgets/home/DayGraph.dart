import 'package:flutter/material.dart';
import 'package:worktracker/widgets/home/PieChart.dart';

class DayGraph extends StatefulWidget {
  @override
  _DayGraphState createState() => _DayGraphState();
}

class _DayGraphState extends State<DayGraph> {
  int done = 3;
  int total = 10;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.of(context).textScaleFactor;

    return Container(
      height: height * 0.32,
      width: width * 0.9,
      margin: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
        top: height * 0.12,
        bottom: height * 0.12
      ),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              child: Center(),
              foregroundPainter: PieChart(done: done, total: total),
            ),
            Container(
              width: width * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                // border: Border.all(width: 0.5, color: Colors.white)
              ),
              child: Text(
                '${(done/total * 100).toInt()}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize * 24.0,
                  fontWeight: FontWeight.bold
                )
              )
            )
          ],
        )
      )
    );
  }
}
