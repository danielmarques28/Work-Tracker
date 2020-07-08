import 'package:flutter/material.dart';

class ItemCarousel extends StatefulWidget {
  final bool active;
  final Map<String, dynamic> day;

  ItemCarousel({
    Key key,
    @required this.active,
    @required this.day
  }) : super(key: key);

  @override
  _ItemCarouselState createState() => _ItemCarouselState();
}

class _ItemCarouselState extends State<ItemCarousel> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.of(context).textScaleFactor;

    return Container(
      width: width * 0.168,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: widget.active ? Colors.blueAccent : Colors.white24
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.day['day'],
            style: TextStyle(
              color: Colors.white,
              fontSize: textSize * 26.0,
              fontWeight: FontWeight.bold
            )
          ),
          Container(height: height * 0.015),
          Text(
            widget.day['weekday'],
            style: TextStyle(
              color: Colors.white70,
              fontSize: textSize * 15.0
            )
          )
        ],
      )
    );
  }
}
