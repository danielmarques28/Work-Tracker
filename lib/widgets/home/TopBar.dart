import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  InkWell touchButton(context, icon) {
    return InkWell(
      onTap: () {
        print('clicou !!!');
      },
      child: IconButton(
        icon: Icon(icon, color: Colors.white,),
        onPressed: null,
        iconSize: 27.0
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double statusbarHeight = MediaQuery.of(context).padding.top;
    double barHeight = MediaQuery.of(context).size.height * 0.085;
    return Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.005,
        right: MediaQuery.of(context).size.width * 0.005
      ),
      height: statusbarHeight + barHeight,
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          touchButton(context, Icons.history),
          touchButton(context, Icons.settings)
        ],
      ),
    );
  }
}
