import 'package:flutter/material.dart';

double deviceWidth(BuildContext context, [double number = 1.0]) {
  final double width = MediaQuery.of(context).size.width * number;
  return width;
}

double deviceHeigth(BuildContext context, [double number = 1.0]) {
  final double height = MediaQuery.of(context).size.height * number;
  return height;
}

double textSize(BuildContext context, double number) {
  double textSize = MediaQuery.of(context).textScaleFactor * number;
  return textSize;
}

double statusBarHeight(BuildContext context) {
  final double statusBarHeight = MediaQuery.of(context).padding.top;
  return statusBarHeight;
}

double barHeight(BuildContext context) {
  return statusBarHeight(context) + topBarHeight(context);
}

double topBarHeight(BuildContext context) {
  return deviceHeigth(context, 0.07);
}
