import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worktracker/models/CalendarFile.dart';
import 'package:worktracker/helpers/responsive.dart';
import 'package:worktracker/helpers/background.dart';
import 'package:worktracker/widgets/home/RowDayCard.dart';
import 'package:worktracker/widgets/home/InfoDay.dart';
import 'package:worktracker/widgets/home/ColumnRoutineCard.dart';
import 'package:worktracker/widgets/home/TopBar.dart';
import 'package:worktracker/widgets/home/DayGraph.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> _calendar;
  bool _showCarousel = false;
  String _selectedDate;
  final GlobalKey<RowDayCardState> _rowDayGlobalKey
    = GlobalKey<RowDayCardState>();
  final GlobalKey<DayGraphState> _dayGraphGlobalKey
    = GlobalKey<DayGraphState>();
  final GlobalKey<ColumnRoutineCardState> _columnGlobalKey
    = GlobalKey<ColumnRoutineCardState>();

  @override
  void initState() {
    super.initState();
    _getCalendarContent();
  }

  void _getCalendarContent() {
    CalendarFile().readFile().then((value) {
      setState(() {
        _calendar = value;
        _selectedDate = DateTime.now().toString().substring(0, 10);
      });
    });
  }

  void _updateFile(List<dynamic> newDayRoutines) {
    CalendarFile().updateDayRoutines(_selectedDate, newDayRoutines);
  }

  void _setShowCarousel(bool value) {
    setState(() => _showCarousel = value);
  }

  void _setSelectedDate(String date) {
    setState(() {
      _selectedDate = date;
    });
    Timer(
      Duration(milliseconds: 50), () {
        _dayGraphGlobalKey.currentState.setData();
        _columnGlobalKey.currentState.sortDayRoutines();
      }
    );
  }

  void _updateDayRoutines(newDayRoutines) {
    setState(() {
      _calendar[_selectedDate] = newDayRoutines;
    });
    _dayGraphGlobalKey.currentState.setData();
    _updateFile(newDayRoutines);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    return Scaffold(
      body: Container(
        height: deviceHeigth(context),
        width: deviceWidth(context),
        decoration: background(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: TopBar()),
            SliverToBoxAdapter(child: Visibility(
              maintainState: true,
              visible: _showCarousel,
              child: RowDayCard(
                key: _rowDayGlobalKey,
                updateSelectedDate: (date) => _setSelectedDate(date),
                close: () => _setShowCarousel(false)
              )
            )),
            SliverToBoxAdapter(child: Visibility(
              visible: !_showCarousel,
              child: _selectedDate != null
                ? InfoDay(
                    selectedDate: _selectedDate,
                    close: () {
                      _setShowCarousel(true);
                      _rowDayGlobalKey.currentState.startCountdown();
                    }
                  )
                : Container()
            )),
            SliverToBoxAdapter(
              child: _calendar != null
                ? DayGraph(
                    key: _dayGraphGlobalKey,
                    dayRoutines: _calendar[_selectedDate]
                  )
                : Container()
            ),
            SliverToBoxAdapter(
              child: _calendar != null
                ? ColumnRoutineCard(
                    key: _columnGlobalKey,
                    dayRoutines: _calendar[_selectedDate],
                    updateFile: (newDayRoutines) =>
                      _updateDayRoutines(newDayRoutines)
                  )
                : Container()
            )
          ]
        )
      )
    );
  }
}
