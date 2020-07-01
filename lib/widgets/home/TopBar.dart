import 'package:flutter/material.dart';
import 'package:worktracker/screens/History.dart';
import 'package:worktracker/screens/Settings.dart';
import 'package:worktracker/widgets/SlideRoute.dart';

class TopBar extends StatelessWidget {
  Material _touchButton(context, icon, button) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        iconSize: 27.0,
        splashRadius: 21.0,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            SlideRoute(
              widget: button == 'history' ? History() : Settings(),
              side: button == 'history' ? 'left' : 'right'
            )
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double barHeight = MediaQuery.of(context).size.height * 0.08;
    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.005,
          right: MediaQuery.of(context).size.width * 0.005),
      height: statusbarHeight + barHeight,
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _touchButton(context, Icons.history, 'history'),
          _touchButton(context, Icons.settings, 'settings')
        ],
      ),
    );
  }
}
