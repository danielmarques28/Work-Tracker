import 'package:flutter/material.dart';

import 'package:worktracker/helpers/responsive.dart';
import 'package:worktracker/widgets/GoBackTopBar.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: deviceHeigth(context),
        width: deviceWidth(context),
        child: Column(
          children: [
            GoBackTopBar(screenTitle: 'Configurações')
          ]
        )
      )
    );
  }
}
