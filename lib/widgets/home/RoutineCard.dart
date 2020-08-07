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
  Color _decideCardColor(int status) {
    switch (status) {
      case 1:
        return Colors.transparent;
      case 2:
        return Theme.of(context).primaryColor;
      case 3:
        return Theme.of(context).accentColor;
      default:
        return Colors.transparent;
    }
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
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(
              width: 1.0,
              color: _decideCardColor(widget.status)
            )
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
