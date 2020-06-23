import 'package:flutter/material.dart';

class SlideRoute extends PageRouteBuilder {
  final Widget widget;
  final String side;

  static Offset decideSideToSlide(side) {
    switch (side) {
      case 'left':
        return Offset(-1.0, 0.0);
      case 'right':
        return Offset(1.0, 0.0);
      default:
        return Offset(-1.0, 0.0);
    }
  }

  SlideRoute({this.widget, this.side})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: decideSideToSlide(side),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        });
}
