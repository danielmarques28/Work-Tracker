import 'dart:math';
import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';
import 'package:worktracker/widgets/home/RoutineCard.dart';

class Background extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String direction;

  Background({
    @required this.color,
    @required this.icon,
    @required this.direction
  });

  List<Widget> _swapRowChildrens(BuildContext context) {
    Widget circleIcon = Container(
      width: deviceWidth(context, 0.13),
      height: deviceHeigth(context, 0.13),
      margin: EdgeInsets.only(left: deviceWidth(context, 0.02), right: deviceWidth(context, 0.02)),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle
      ),
      child: Icon(icon, color: Colors.white, size: 35.0)
    );
    Widget arrowIcon = Transform.rotate(
      angle: direction == 'startToEnd' ? pi : pi * 2,
      child: Container(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 26.0
        )
      )
    );

    List<Widget> rowList = [circleIcon];

    if(direction == 'startToEnd')
      rowList.add(arrowIcon);
    else
      rowList.insert(0, arrowIcon);

    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: direction == 'startToEnd' ?
          Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        width: deviceWidth(context, 0.26),
        child: Row(children: _swapRowChildrens(context))
      )
    );
  }
}

class ColumnRoutineCard extends StatefulWidget {
  ColumnRoutineCard({Key key}) : super(key: key);

  @override
  _ColumnRoutineCardState createState() => _ColumnRoutineCardState();
}

class _ColumnRoutineCardState extends State<ColumnRoutineCard> {
  final List<RoutineCard> cards = List.generate(
    6, (index) => RoutineCard()
  );

  @override
  Widget build(BuildContext context) {
    final Widget snackbar = SnackBar(
      duration: Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Rotina removida',
            style: TextStyle(color: Colors.white)
          ),
          Text(
            'Desfazer',
            style: TextStyle(color: Colors.white)
          )
        ],
      )
    );

    return Container(
      margin: EdgeInsets.only(
        left: deviceWidth(context, 0.05),
        right: deviceWidth(context, 0.05),
        bottom: deviceHeigth(context, 0.018)
      ),
      alignment: Alignment.center,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: deviceHeigth(context, 0.0125)),
            child: Center(
              child: Dismissible(
                key: UniqueKey(),
                background: Background(
                  color: Colors.green,
                  icon: Icons.check,
                  direction: 'startToEnd'
                ),
                secondaryBackground: Background(
                  color: Colors.red,
                  icon: Icons.close,
                  direction: 'endToStart'
                ),
                onDismissed: (direction) {
                  setState(() {
                    cards.removeAt(index);
                  });
                  Scaffold.of(context).showSnackBar(snackbar);
                },
                child: cards[index]
              )
            )
          );
        }
      )
    );
  }
}
