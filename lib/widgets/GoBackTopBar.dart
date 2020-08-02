import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: () {
        Navigator.pop(context);
      },
      splashColor: Colors.white24,
      icon: Icon(Icons.arrow_back, color: Colors.white),
      label: Text(
        'Voltar',
        style: TextStyle(color: Colors.white)
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0)
      )
    );
  }
}

class GoBackTopBar extends StatelessWidget {
  final String screenTitle;

  GoBackTopBar({@required this.screenTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: statusBarHeight(context),
        left: deviceWidth(context, 0.005),
        right: deviceWidth(context, 0.005)
      ),
      height: barHeight(context),
      width: deviceWidth(context),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black54)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBackButton(),
          Text(
            screenTitle.toUpperCase(),
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
