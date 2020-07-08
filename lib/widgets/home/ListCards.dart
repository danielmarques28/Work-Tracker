import 'package:flutter/material.dart';
import 'package:worktracker/widgets/home/TaskCard.dart';

class Background extends StatelessWidget {
  Background({@required this.color, @required this.icon, @required this.direction});

  final Color color;
  final IconData icon;
  final String direction;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: direction == 'startToEnd' ?
          Alignment.centerLeft : Alignment.centerRight,
        padding: EdgeInsets.only(left: width * 0.025, right: width * 0.025),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40.0)
        ),
        child: Icon(icon, color: Colors.white, size: 40.0)
      )
    );
  }
}

class ListCards extends StatefulWidget {
  ListCards({Key key}) : super(key: key);

  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<ListCards> {
  final items = List.generate(6, (index) => TaskCard());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
      alignment: Alignment.center,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 15.0),
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
                    items.removeAt(index);
                  });
                },
                child: items[index]
              )
            )
          );
        }
      )
    );
  }
}
