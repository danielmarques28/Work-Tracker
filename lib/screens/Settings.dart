import 'package:flutter/material.dart';
import 'package:worktracker/helpers/background.dart';
import 'package:worktracker/helpers/responsive.dart';
import 'package:worktracker/widgets/GoBackTopBar.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: deviceHeigth(context),
        width: deviceWidth(context),
        decoration: background(),
        child: Column(
          children: [
            GoBackTopBar(screenName: 'Configurações')
          ]
        )
      )
    );
  }
}
