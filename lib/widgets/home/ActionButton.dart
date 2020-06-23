import 'dart:ui';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  var _dateTime;
  double _percentage = 0.0;
  String _buttonState = 'ENTRADA';

  _controlButton() {
    if (_buttonState == 'ENTRADA') {
      setState(() {
        _dateTime = DateTime.now();
      });
      _getStateButton('PARAR');
    } else {
      setState(() {
        _dateTime = DateTime.now();
      });
      _getStateButton('ENTRADA');
    }
  }

  _getStateButton(state) {
    setState(() {
      _buttonState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.56,
      width: MediaQuery.of(context).size.width * 1,
      child: Center(
        child: GestureDetector(
          onTap: () {
            _controlButton();
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 150),
                height: 160.0,
                width: 160.0,
                decoration: BoxDecoration(
                  border: _buttonState != 'ENTRADA' ? (
                    Border.all(width: 4.0, color: Colors.orangeAccent)
                  ) : null,
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    _buttonState,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
