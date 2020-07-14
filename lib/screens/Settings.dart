import 'package:flutter/material.dart';
import 'package:worktracker/helpers/background.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double barHeight = height * 0.07;
    double statusbarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: background(),
        child: Column(
          children: [
            Container(height: statusbarHeight + barHeight),
            Container(child: Text('Settings', style: TextStyle(color: Colors.white)))
          ],
        )
      )
    );
  }
}
