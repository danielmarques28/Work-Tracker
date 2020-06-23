import 'package:flutter/material.dart';

BoxDecoration background() {
  return BoxDecoration(
    gradient: LinearGradient(
        colors: [Color(0xFF281b47), Color(0xFF733178)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.1, 1.0],
        tileMode: TileMode.clamp),
  );
}
