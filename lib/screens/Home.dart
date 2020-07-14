import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worktracker/models/CalendarFile.dart';
import 'package:worktracker/widgets/home/RowDayCard.dart';
import 'package:worktracker/widgets/home/InfoDay.dart';
import 'package:worktracker/widgets/home/ColumnRoutineCard.dart';
import 'package:worktracker/widgets/home/TopBar.dart';
import 'package:worktracker/widgets/home/DayGraph.dart';
import 'package:worktracker/helpers/background.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> calendar;
  bool showCarousel = false;
  String selectedDate = DateTime.now().toString().substring(0, 10);
  final GlobalKey<RowDayCardState> _globalKey = GlobalKey<RowDayCardState>();

  @override
  void initState() {
    super.initState();
    _getCalendarContent();
  }

  void _getCalendarContent() async {
    await CalendarFile().readFile().then((value) {
      setState(() => calendar = value);
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: background(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: TopBar()),
            SliverToBoxAdapter(
              child: Visibility(
                maintainState: true,
                visible: showCarousel,
                child: RowDayCard(
                  key: _globalKey,
                  updateSelectedDate: (value) => _setSelectedDate(value),
                  close: () => _setShowCarousel(false)
                )
              )
            ),
            SliverToBoxAdapter(child: Visibility(
              visible: !showCarousel,
              child: InfoDay(
                close: () {
                  _setShowCarousel(true);
                  _globalKey.currentState.startCountdown();
                }
              )
            )),
            SliverToBoxAdapter(child: DayGraph()),
            SliverToBoxAdapter(child: ColumnRoutineCard())
          ]
        )
      )
    );
  }
}
