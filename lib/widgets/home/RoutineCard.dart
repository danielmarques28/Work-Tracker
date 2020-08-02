import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';

class RoutineCard extends StatefulWidget {
  RoutineCard({
    Key key,
    @required this.routine,
    @required this.status
  }) : super(key: key);

  final Map<dynamic, dynamic> routine;
  final int status;

  @override
  _RoutineCardState createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard> {
  Color _decideCardColor() {
    Color color;
    switch (widget.status) {
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
        borderRadius: BorderRadius.circular(7.0),
        onTap: () {
          print('press');
        },
        child: Container(
          width: deviceWidth(context, 0.95),
          height: 89.0,
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
                    '${widget.routine['name']}'.toUpperCase(),
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
                    '${widget.routine['description']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize(context, 15.0)
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
