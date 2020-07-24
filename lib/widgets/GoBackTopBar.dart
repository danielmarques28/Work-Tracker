import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: () {
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
      },
      splashColor: Colors.white24,
      icon: Icon(Icons.arrow_back, color: Colors.white),
      label: Text(
        'Voltar',
        style: TextStyle(color: Colors.white70)
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      )
    );
  }
}

class GoBackTopBar extends StatelessWidget {
  final String screenName;

  GoBackTopBar({@required this.screenName});

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
          CustomBackButton(),
          Text(
            screenName.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: textSize(context, 18.0),
              fontWeight: FontWeight.bold
            )
          ),
          Container(width: deviceWidth(context, 0.25))
        ]
      )
    );
  }
}
