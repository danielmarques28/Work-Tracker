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

class CreateRoutineButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(1.0, 3.0),
            color: Colors.black,
            blurRadius: 0.5,
            spreadRadius: 0.5
          )
        ]
      ),
      child: FlatButton.icon(
        onPressed: () =>
          Navigator.pushNamed(context, '/create-routine'),
        splashColor: Colors.white24,
        color: Colors.blueAccent,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          'ROTINA',
          style: TextStyle(color: Colors.white)
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0)
        )
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
          CreateRoutineButton(),
          TouchButton(icon: Icons.settings, type: 'settings'),
        ]
      )
    );
  }
}
