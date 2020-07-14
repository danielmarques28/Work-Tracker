import 'dart:math';
import 'package:flutter/material.dart';
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

  List<Widget> _swapRowChildrens(double width, double height) {
    Widget circleIcon = Container(
      width: width * 0.13,
      height: height * 0.13,
      margin: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Align(
      alignment: direction == 'startToEnd' ?
          Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        width: width * 0.26,
        child: Row(children: _swapRowChildrens(width, height))
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
        left: width * 0.05,
        right: width * 0.05,
        bottom: height * 0.018
      ),
      alignment: Alignment.center,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: height * 0.0125),
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
