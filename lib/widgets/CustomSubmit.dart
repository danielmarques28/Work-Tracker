import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';

class CustomSubmit extends StatelessWidget {
  final Function callback;

  CustomSubmit({@required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: deviceHeigth(context, 0.05)
      ),
      child: ButtonTheme(
        minWidth: deviceWidth(context, 0.95),
        height: 52.0,
        child: RaisedButton.icon(
          splashColor: Theme.of(context).splashColor,
          color: Theme.of(context).primaryColor,
          onPressed: () => callback(),
          icon: Icon(
            Icons.create,
            color: Colors.white
          ),
          label: Text(
            'SALVAR',
            style: TextStyle(color: Colors.white)
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0)
          )
        )
      )
    );
  }
}
