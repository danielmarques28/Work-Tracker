import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  var _dateTime;
  String _buttonState = 'ENTRADA';

  @override
  void initState() {
    super.initState();
  }

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
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 1,
      child: Center(
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: GestureDetector(
            onTap: () {
              _controlButton();
            },
            child: ClipOval(
              child: Container(
                color: Colors.white,
                height: 130.0,
                width: 130.0,
                child: Center(
                  child: Text(
                    _buttonState,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
