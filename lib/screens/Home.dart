import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worktracker/models/CalendarFile.dart';
import 'package:worktracker/helpers/responsive.dart';
import 'package:worktracker/widgets/home/RowDayCard.dart';
import 'package:worktracker/widgets/home/InfoDay.dart';
import 'package:worktracker/widgets/home/ColumnRoutineCard.dart';
import 'package:worktracker/widgets/home/TopBar.dart';
import 'package:worktracker/widgets/home/DayGraph.dart';

class FloatingButton extends StatelessWidget {
  final Function getCalendarContent;
  final GlobalKey<DayGraphState> dayGraphGlobalKey;
  final GlobalKey<ColumnRoutineCardState> columnGlobalKey;

  FloatingButton({
    @required this.getCalendarContent,
    @required this.dayGraphGlobalKey,
    @required this.columnGlobalKey
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        Navigator.pushNamed(context, '/create-routine')
          .then((calendar) {
            if(calendar != null) {
              getCalendarContent();
              Timer(
                Duration(milliseconds: 100), () {
                  dayGraphGlobalKey.currentState.setData();
                  columnGlobalKey.currentState.addNewRoutine();
                }
              );
            }
          });
      },
      child: Icon(
        Icons.add,
        size: 32.0,
        color: Colors.white
      )
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> _calendar;
  bool _showCarousel = false;
  String _selectedDate = DateTime.now().toString().substring(0, 10);
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

  Future<void> _getCalendarContent() async {
    CalendarFile().readFile()
      .then((calendar) {
        setState(() => _calendar = calendar);
        if(_calendar[_selectedDate] == null) {
          CalendarFile().saveTodayInFile(_selectedDate)
            .then((newCalendar) {
              setState(() => _calendar = newCalendar);
            });
        }
      });
  }
  
  void _setShowCarousel(bool value) {
    setState(() => _showCarousel = value);
  }

  void _updateChildWidgets() {
    Timer(
      Duration(milliseconds: 100), () {
        _dayGraphGlobalKey.currentState.setData();
        _columnGlobalKey.currentState.sortDayRoutines();
      }
    );
  }

  void _setSelectedDate(String date) {
    setState(() => _selectedDate = date);
    _updateChildWidgets();
  }

  void _updateDayRoutines(newDayRoutines) {
    setState(() {
      _calendar[_selectedDate] = newDayRoutines;
    });
    _dayGraphGlobalKey.currentState.setData();
    CalendarFile().updateDayRoutines(_selectedDate, newDayRoutines);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingButton(
        getCalendarContent: () => _getCalendarContent(),
        dayGraphGlobalKey: _dayGraphGlobalKey,
        columnGlobalKey: _columnGlobalKey
      ),
      body: Container(
        height: deviceHeigth(context),
        width: deviceWidth(context),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: TopBar()),
            SliverToBoxAdapter(
              child: AnimatedCrossFade(
                firstChild: RowDayCard(
                  key: _rowDayGlobalKey,
                  updateSelectedDate: (date) => _setSelectedDate(date),
                  close: () => _setShowCarousel(false)
                ),
                secondChild: InfoDay(
                  selectedDate: _selectedDate,
                  close: () {
                    _setShowCarousel(true);
                    _rowDayGlobalKey.currentState.startCountdown();
                  }
                ),
                crossFadeState: _showCarousel
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 500)
              )
            ),
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
                    updateFile: (newDayRoutines) {
                      _updateDayRoutines(newDayRoutines);
                    }
                  )
                : Container()
            )
          ]
        )
      )
    );
  }
}
