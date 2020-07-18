import 'dart:math';
import 'package:flutter/material.dart';
import 'package:worktracker/helpers/responsive.dart';
import 'package:worktracker/widgets/home/RoutineCard.dart';

class Background extends StatelessWidget {
  final Color color;
  final IconData icon;
  final DismissDirection direction;

  Background({
    @required this.color,
    @required this.icon,
    @required this.direction
  });

  List<Widget> _swapRowChildrens(BuildContext context) {
    Widget circleIcon = Container(
      width: deviceWidth(context, 0.13),
      height: deviceHeigth(context, 0.13),
      margin: EdgeInsets.only(
        left: deviceWidth(context, 0.02),
        right: deviceWidth(context, 0.02)
      ),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle
      ),
      child: Icon(icon, color: Colors.white, size: 35.0)
    );
    Widget arrowIcon = Transform.rotate(
      angle: direction == DismissDirection.startToEnd ? pi : pi * 2,
      child: Container(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 26.0
        )
      )
    );

    List<Widget> rowList = [circleIcon];

    if(direction == DismissDirection.startToEnd)
      rowList.add(arrowIcon);
    else
      rowList.insert(0, arrowIcon);

    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: direction == DismissDirection.startToEnd ?
          Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        width: deviceWidth(context, 0.26),
        child: Row(children: _swapRowChildrens(context))
      )
    );
  }
}

class ColumnRoutineCard extends StatefulWidget {
  ColumnRoutineCard({
    Key key,
    @required this.dayRoutines
  }) : super(key: key);

  final List<dynamic> dayRoutines;

  @override
  _ColumnRoutineCardState createState() => _ColumnRoutineCardState();
}

class _ColumnRoutineCardState extends State<ColumnRoutineCard> {
  List<RoutineCard> _listCards;
  final GlobalKey<AnimatedListState> _listGlobalKey
    = GlobalKey<AnimatedListState>();
  List _dayRoutines;

  @override
  void initState() {
    super.initState();
    setState(() => _dayRoutines = widget.dayRoutines);
    sortDayRoutines();
    generateListCards();
  }

  sortDayRoutines() {
    setState(() {
      _dayRoutines.sort((a, b) => a['status'].compareTo(b['status']));
    });
  }

  generateListCards() {
    setState(() {
      _listCards = List.generate(
        _dayRoutines.length,
        (index) => RoutineCard(
          routine: _dayRoutines[index]
        )
      );
    });
  }

  SnackBar getSnackBar(RoutineCard deletedCard, int index) {
    final Text content = Text(
      '"Rotina ${_dayRoutines[index]['routine_id']}" não realizada',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white
      )
    );

    final Material actionButton = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(7.0),
        onTap: () {
          setState(() {
            _listCards.insert(index, deletedCard);
          });
          _listGlobalKey.currentState.insertItem(index);
          Scaffold.of(context).hideCurrentSnackBar();
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0)
          ),
          child: Text(
            'Desfazer',
            style: TextStyle(color: Colors.white)
          )
        )
      )
    );

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          content,
          actionButton
        ]
      )
    );
  }

  decideDirection(int status) {
    switch (status) {
      case 1:
        return DismissDirection.horizontal;
      case 2:
        return DismissDirection.endToStart;
      case 3:
        return DismissDirection.startToEnd;
    }
  }

  RoutineCard deleteCard(DismissDirection direction, int index) {
    RoutineCard deletedCard;
    setState(() {
      deletedCard = _listCards.removeAt(index);
    });
    _listGlobalKey.currentState
      .removeItem(
        index, (context, animation) => Container()
      );
    // Scaffold.of(context)
    //   .showSnackBar(getSnackBar(deletedCard, index));
    return deletedCard;
  }

  void insertCard(DismissDirection direction, RoutineCard deletedCard) {
    final int statusTarget =
      direction == DismissDirection.startToEnd ? 2 : 3;
    final int insertIndex = _dayRoutines.indexWhere(
      (element) => element['status'] == statusTarget
    ) - 1;
    setState(() {
      _listCards.insert(insertIndex, deletedCard);
      _listGlobalKey.currentState
        .insertItem(insertIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context, 0.9),
      margin: EdgeInsets.only(
        left: deviceWidth(context, 0.05),
        right: deviceWidth(context, 0.05),
        bottom: deviceHeigth(context, 0.018)
      ),
      alignment: Alignment.center,
      child: AnimatedList(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        key: _listGlobalKey,
        initialItemCount: _listCards.length,
        itemBuilder: (context, index, animation) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              bottom: deviceHeigth(context, 0.0125)
            ),
            child: Center(
              child: Dismissible(
                key: Key('${_listCards[index]}'),
                background: Background(
                  color: Colors.green,
                  icon: Icons.check,
                  direction: DismissDirection.startToEnd
                ),
                secondaryBackground: Background(
                  color: Colors.red,
                  icon: Icons.close,
                  direction: DismissDirection.endToStart
                ),
                direction:
                  decideDirection(_dayRoutines[index]['status']),
                onDismissed: (direction) {
                  RoutineCard deletedCard
                    = deleteCard(direction, index);
                  insertCard(direction, deletedCard);
                },
                child: SizeTransition(
                  axis: Axis.vertical,
                  sizeFactor: animation,
                  child: _listCards[index]
                )
              )
            )
          );
        }
      )
    );
  }
}
