import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Container bottomContainer(context, title, value, border) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        border: border ? Border(
          left: BorderSide(width: 0.2, color: Colors.white),
          right: BorderSide(width: 0.2, color: Colors.white)
        ) : null
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            'H     M',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ),
      child: Row(
        children: [
          bottomContainer(context, 'ENTRADA', '8:00', false),
          bottomContainer(context, 'SAÍDA', '18:00', true),
          bottomContainer(context, 'RESTA', '5:00', false),
        ],
      ),
    );
  }
}
