import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    var statusbarHeight = MediaQuery.of(context).padding.top;
    var barHeight = MediaQuery.of(context).size.height * 0.085;
    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      margin: EdgeInsets.only(left: 4.0, right: 4.0),
      height: statusbarHeight + barHeight,
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.history, color: Colors.white,),
            onPressed: null,
            iconSize: 27.0
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white,),
            onPressed: null,
            iconSize: 27.0
          ),
        ],
      ),
    );
  }
}
