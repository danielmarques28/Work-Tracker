import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:worktracker/widgets/home/ItemCarousel.dart';

class CarouselDay extends StatefulWidget {
  final Function callback;

  CarouselDay({@required this.callback});

  @override
  _CarouselDayState createState() => _CarouselDayState();
}

class _CarouselDayState extends State<CarouselDay> {
  List<Map<String, dynamic>> days;
  int activeIndex = 0;
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);

  @override
  void initState() {
    super.initState();
    _generateDaysList();
  }

  void _generateDaysList() {
    List<Map<String, dynamic>> items = List.generate(7, (index) {
      final DateTime dateTimeNow = DateTime.now().add(Duration(days: -index));
      final String weekday = DateFormat.EEEE().format(dateTimeNow);
      final Object day = {
        'date': dateTimeNow,
        'day': dateTimeNow.day.toString(),
        'weekday': weekday.substring(0, 3).toUpperCase()
      };
      return day;
    });

    setState(() {
      days = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(
        top: height * 0.04,
        left: width * 0.04,
        right: width * 0.04,
      ),
      height: height * 0.105,
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(7.0),
                  onTap: () {
                    setState(() {
                      activeIndex = index;
                    });
                    final String date = days[index]['date'].toString().substring(0, 10);
                    widget.callback(date);
                  },
                  child: ItemCarousel(
                    active: index == activeIndex,
                    day: days[index]
                  )
                )
              ),
              Container(width: index > 0 ? width * 0.02 : 0)
            ]
          );
        }
      )
    );
  }
}
