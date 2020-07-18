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
  Map<String, dynamic> calendar;
  bool showCarousel = false;
  String selectedDate;
  final GlobalKey<RowDayCardState> _globalKey = GlobalKey<RowDayCardState>();

  @override
  void initState() {
    super.initState();
    _getCalendarContent();
  }

  void _getCalendarContent() {
    CalendarFile().readFile().then((value) {
      setState(() {
        calendar = value;
        selectedDate = DateTime.now().toString().substring(0, 10);
        calendar[selectedDate] = [];
      });
      for (int i = 1; i <= 3; i++) {
        setState(() {
          calendar[selectedDate].add({'routine_id': i, 'status': 1});
        });
      }
      for (int i = 4; i <= 6; i++) {
        setState(() {
          calendar[selectedDate].add({'routine_id': i, 'status': 2});
        });
      }
      for (int i = 7; i <= 9; i++) {
        setState(() {
          calendar[selectedDate].add({'routine_id': i, 'status': 3});
        });
      }
    });
  }

  void _setShowCarousel(bool value) {
    setState(() => showCarousel = value);
  }

  void _setSelectedDate(String value) {
    setState(() => selectedDate = value);
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
              visible: showCarousel,
              child: RowDayCard(
                key: _globalKey,
                updateSelectedDate: (value) => _setSelectedDate(value),
                close: () => _setShowCarousel(false)
              )
            )),
            SliverToBoxAdapter(child: Visibility(
              visible: !showCarousel,
              child: InfoDay(
                close: () {
                  _setShowCarousel(true);
                  _globalKey.currentState.startCountdown();
                }
              )
            )),
            SliverToBoxAdapter(
              child: calendar != null
                ? DayGraph(dayRoutines: calendar[selectedDate])
                : Container()
            ),
            SliverToBoxAdapter(
              child: calendar != null
                ? ColumnRoutineCard(dayRoutines: calendar[selectedDate])
                : Container()
            )
          ]
        )
      )
    );
  }
}
