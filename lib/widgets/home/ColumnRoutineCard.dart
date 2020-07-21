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
      width: deviceWidth(context, 0.11),
      height: deviceHeigth(context, 0.11),
      margin: EdgeInsets.only(
        left: deviceWidth(context, 0.01),
        right: deviceWidth(context, 0.01)
      ),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle
      ),
      child: Icon(icon, color: Colors.white, size: 30.0)
    );
    Widget arrowIcon = Transform.rotate(
      angle: direction == DismissDirection.startToEnd ? pi : pi * 2,
      child: Container(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 23.0
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
        width: deviceWidth(context, 0.19),
        child: Row(children: _swapRowChildrens(context))
      )
    );
  }
}

class ColumnRoutineCard extends StatefulWidget {
  ColumnRoutineCard({
    Key key,
    @required this.dayRoutines,
    @required this.updateFile
  }) : super(key: key);

  final List<dynamic> dayRoutines;
  final Function updateFile;

  @override
  ColumnRoutineCardState createState() => ColumnRoutineCardState();
}

class ColumnRoutineCardState extends State<ColumnRoutineCard> {
  final GlobalKey<AnimatedListState> _listGlobalKey
    = GlobalKey<AnimatedListState>();
  List<dynamic> _dayRoutines;

  @override
  void initState() {
    super.initState();
    sortDayRoutines();
  }

  sortDayRoutines() {
    setState(() {
      _dayRoutines = widget.dayRoutines;
      _dayRoutines.sort((a, b) {
        return a['status'].compareTo(b['status']);
      });
    });
  }

  DismissDirection _decideDirection(int status) {
    DismissDirection direction;
    switch (status) {
      case 1:
        direction = DismissDirection.horizontal;
        break;
      case 2:
        direction = DismissDirection.endToStart;
        break;
      case 3:
        direction = DismissDirection.startToEnd;
        break;
    }
    return direction;
  }

  _removeItem(int removeIndex) {
    Map routine;
    setState(() {
      routine = _dayRoutines.removeAt(removeIndex);
    });
    _listGlobalKey.currentState.removeItem(
      removeIndex, (context, animation) =>  Container()
    );

    return routine;
  }

  void _insertItem(DismissDirection direction, Map newItem) {
    int statusTarget;
    if(direction == DismissDirection.startToEnd) {
      statusTarget = 2;
      newItem['status'] = 2;
    }
    else {
      statusTarget = 3;
      newItem['status'] = 3;
    }

    int insertIndex = _dayRoutines.indexWhere(
      (element) => element['status'] == statusTarget
    );

    if(insertIndex == -1) {
      if(statusTarget == 2) {
        insertIndex = _dayRoutines.lastIndexWhere(
          (element) => element['status'] == 1
        );
        insertIndex += 1;
      }
      else if(statusTarget == 3)
        insertIndex = _dayRoutines.length;
    }

    setState(() {
      _dayRoutines.insert(insertIndex, newItem);
      _listGlobalKey.currentState.insertItem(insertIndex);
    });
    widget.updateFile?.call(_dayRoutines);
  }

  Widget _buildDismissible(routine, index, animation) {
    return Dismissible(
      key: UniqueKey(),
      background: Background(
        color: Colors.blueAccent,
        icon: Icons.check,
        direction: DismissDirection.startToEnd
      ),
      secondaryBackground: Background(
        color: Colors.redAccent,
        icon: Icons.close,
        direction: DismissDirection.endToStart
      ),
      direction:
        _decideDirection(routine['status']),
      onDismissed: (direction) {
        Map removedItem = _removeItem(index);
        _insertItem(direction, removedItem);
      },
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: RoutineCard(routine: routine)
      )
    );
  }

  Widget _buildItem(routine, index, animation) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        bottom: deviceHeigth(context, 0.0125)
      ),
      child: _buildDismissible(routine, index, animation)
    );
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
      child: _dayRoutines.length > 0
        ? AnimatedList(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            key: _listGlobalKey,
            initialItemCount: _dayRoutines.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(_dayRoutines[index], index, animation);
            }
          )
        : Container()
    );
  }
}
