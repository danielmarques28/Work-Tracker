import 'dart:math';
import 'package:flutter/material.dart';

class PieChart extends StatefulWidget {
  PieChart({
    @required this.done,
    @required this.undone,
    @required this.total
  });

  final int done;
  final int undone;
  final int total;

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart>
  with SingleTickerProviderStateMixin {
  double done = 0.0;
  double undone = 0.0;
  Animation<double> _animationDone;
  Animation<double> _animationUndone;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    done = widget.done.toDouble();
    undone = widget.undone.toDouble();

    controller = AnimationController(
      duration: Duration(milliseconds: 1600),
      vsync: this
    );

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed)
        controller.forward();
    });

    _animationDone = Tween(begin: 0.0, end: done).animate(controller)
      ..addListener(() {
        setState(() {
          done = _animationDone.value;
        });
      });

    _animationUndone = Tween(begin: 0.0, end: undone).animate(controller)
      ..addListener(() {
        setState(() {
          undone = _animationUndone.value;
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(),
      painter: PieChartPainter(
        done: done,
        undone: undone,
        total: widget.total
      )
    );
  }
}

class PieChartPainter extends CustomPainter {
  PieChartPainter({
    @required this.done,
    @required this.undone,
    @required this.total
  });

  final double done;
  final double undone;
  final int total;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2.7, size.height / 2.7);

    Paint outerCircle = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white24
      ..strokeWidth = 60.0;

    canvas.drawCircle(center, radius, outerCircle);

    Paint completeCircle = Paint()
      ..style = PaintingStyle.stroke
      // ..strokeCap = StrokeCap.round
      ..strokeWidth = 60.0;

    double startRadian = -pi / 2;

    List colors = [Colors.blueAccent, Colors.redAccent];

    double sweepRadian = 0;
    for (int index = 0; index < 2; index++) {
      if(index == 0)
        sweepRadian = (done / total) * 2 * pi;
      else
        sweepRadian = (undone / total) * 2 * pi;

      completeCircle.color = colors[index];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        completeCircle
      );

      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
