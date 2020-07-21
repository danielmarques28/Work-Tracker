import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';

class RoutineCard extends StatefulWidget {
  RoutineCard({Key key, @required this.routine});

  final Map<String, dynamic> routine;

  @override
  _RoutineCardState createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  Color _decideCardColor() {
    Color color;
    switch (widget.routine['status']) {
      case 1:
        color = Colors.white;
        break;
      case 2:
        color = Colors.blueAccent;
        break;
      case 3:
        color = Colors.redAccent;
        break;
    }
    return color.withOpacity(0.24);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onLongPress: () {
          print('routine card long press');
        },
        child: Container(
          width: deviceWidth(context, 0.9),
          height: deviceHeigth(context, 0.12),
          decoration: BoxDecoration(
            color: _decideCardColor(),
            borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(
            padding: EdgeInsets.only(
              left: deviceWidth(context, 0.05),
              right: deviceWidth(context, 0.05),
              top: deviceHeigth(context, 0.015),
              bottom: deviceHeigth(context, 0.015)
            ),
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Rotina ${widget.routine['routine_id']}'.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize(context, 19.0),
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Descrição sobre essa rotina',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize(context, 15.0),
                    )
                  )
                )
              ],
            )
          )
        )
      )
    );
  }
}
