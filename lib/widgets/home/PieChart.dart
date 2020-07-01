import 'dart:math';
import 'package:flutter/material.dart';

class PieChart extends CustomPainter {
  PieChart({@required this.done, @required this.total});

  final int done;
  final int total;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2.7, size.height / 2.7);

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 60.0;

    double startRadian = -pi / 2;

    List colors = [Colors.blueAccent, Colors.white30];

    double sweepRadian = 0;
    for (int i = 0; i < 2; i++) {
      if(i == 0)
        sweepRadian = (done / total) * 2 * pi;
      else
        sweepRadian = ((total - done) / total) * 2 * pi;

      paint.color = colors[i];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint
      );

      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
