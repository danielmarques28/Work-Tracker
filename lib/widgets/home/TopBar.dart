import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';

class TouchButton extends StatelessWidget {
  final IconData icon;
  final String type;

  TouchButton({
    Key key,
    @required this.icon,
    @required this.type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        color: Colors.black26,
        iconSize: 27.0,
        splashRadius: 21.0,
        icon: Icon(icon, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, '/$type')
      )
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight(context)),
      margin: EdgeInsets.only(
        left: deviceWidth(context, 0.005),
        right: deviceWidth(context, 0.005)
      ),
      height: barHeight(context),
      width: deviceWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TouchButton(icon: Icons.history, type: 'history'),
          TouchButton(icon: Icons.settings, type: 'settings')
        ]
      )
    );
  }
}
