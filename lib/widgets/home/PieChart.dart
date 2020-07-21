import 'dart:math';
import 'package:flutter/material.dart';

class PieChart extends StatefulWidget {
  PieChart({
    Key key,
    @required this.done,
    @required this.undone,
    @required this.total
  }) : super(key : key);

  final double done;
  final double undone;
  final int total;

  @override
  PieChartState createState() => PieChartState();
}

class PieChartState extends State<PieChart>
  with SingleTickerProviderStateMixin {
  double _done = 0.0;
  double _undone = 0.0;
  Animation<double> _doneAnimation;
  Animation<double> _undoneAnimation;
  Tween<double> _doneTween;
  Tween<double> _undoneTween;
  AnimationController _controllerAnimation;

  @override
  void initState() {
    super.initState();
    setState(() {
      _done = widget.done;
      _undone = widget.undone;
    });

    _controllerAnimation = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this
    );

    _controllerAnimation.forward();

    _doneTween = Tween(begin: 0.0, end: _done);
    _doneAnimation = _doneTween.animate(_controllerAnimation)
      ..addListener(() {
        setState(() => _done = _doneAnimation.value);
      });

    _undoneTween = Tween(begin: 0.0, end: _undone);
    _undoneAnimation = _undoneTween.animate(_controllerAnimation)
      ..addListener(() {
        setState(() => _undone = _undoneAnimation.value);
      });
  }

  void setData(double doneCount, double undoneCount) {
    _doneTween.begin = _doneTween.end;
    _controllerAnimation.reset();
    _doneTween.end = doneCount;
    _controllerAnimation.forward();

    _undoneTween.begin = _undoneTween.end;
    _controllerAnimation.reset();
    _undoneTween.end = undoneCount;
    _controllerAnimation.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(),
      painter: PieChartPainter(
        done: _done,
        undone: _undone,
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
  bool shouldRepaint(PieChartPainter oldDelegate) => true;
}
