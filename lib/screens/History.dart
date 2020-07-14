import 'package:flutter/material.dart';
import 'package:worktracker/helpers/background.dart';
import 'package:worktracker/helpers/responsive.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: deviceHeigth(context),
        width: deviceWidth(context),
        decoration: background(),
        child: Column(
          children: [
            Container(height: barHeight(context)),
            Container(child: Text('History', style: TextStyle(color: Colors.white)))
          ],
        )
      )
    );
  }
}
