import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';
import 'package:worktracker/widgets/home/PieChart.dart';

class DayGraph extends StatefulWidget {
  DayGraph({@required this.dayRoutines});

  final List<dynamic> dayRoutines;

  @override
  _DayGraphState createState() => _DayGraphState();
}

class _DayGraphState extends State<DayGraph> {
  int done;
  int undone;
  int total;

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    int doneCount = 0;
    int undoneCount = 0;
    for(Map<String, dynamic> dayRoutine in widget.dayRoutines) {
      if(dayRoutine['status'] == 2)
        doneCount += 1;
      else if(dayRoutine['status'] == 3)
        undoneCount += 1;
    }
    setState(() {
      done = doneCount;
      undone = undoneCount;
      total = widget.dayRoutines.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeigth(context, 0.32),
      width: deviceHeigth(context, 0.9),
      margin: EdgeInsets.only(
        left: deviceHeigth(context, 0.05),
        right: deviceHeigth(context, 0.05),
        top: deviceHeigth(context, 0.12),
        bottom: deviceHeigth(context, 0.12)
      ),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              done: done,
              undone: undone,
              total: total
            ),
            Container(
              width: deviceWidth(context, 0.3),
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Text(
                '${(done/total * 100).toInt()}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize(context, 24.0),
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
