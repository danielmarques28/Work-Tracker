import 'package:flutter/material.dart';
import 'package:worktracker/screens/History.dart';
import 'package:worktracker/screens/Settings.dart';
import 'package:worktracker/widgets/SlideRoute.dart';

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
          Navigator.push(
            context,
            SlideRoute(
              widget: type == 'history' ? History() : Settings(),
              side: type == 'history' ? 'left' : 'right'
            )
          );
        },
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final Function action;

  const TopBar({Key key, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double barHeight = height * 0.07;
    double statusbarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      margin: EdgeInsets.only(
        left: width * 0.005,
        right: width * 0.005
      ),
      height: statusbarHeight + barHeight,
      width: width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TouchButton(icon: Icons.history, type: 'history'),
          TouchButton(icon: Icons.settings, type: 'settings')
        ],
      ),
    );
  }
}
