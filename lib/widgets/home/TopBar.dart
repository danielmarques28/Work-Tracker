import 'dart:async';
import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';

class TouchButton extends StatelessWidget {
  final IconData icon;
  final String type;

  TouchButton({Key key, this.icon, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Timer(Duration(milliseconds: 100), () =>
            Navigator.pushNamed(context, '/history')
          );
        },
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final Function action;

  TopBar({Key key, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight(context)),
      margin: EdgeInsets.only(
        left: deviceWidth(context, 0.005),
        right: deviceWidth(context, 0.005),
        bottom: deviceHeigth(context, 0.02)
      ),
      height: barHeight(context),
      width: deviceWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TouchButton(icon: Icons.history, type: 'history')
        ],
      ),
    );
  }
}
