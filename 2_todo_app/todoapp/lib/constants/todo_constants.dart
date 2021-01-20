import 'package:flutter/material.dart';

String logoImg = 'assets/images/logo.png';
Color lightBlue = Color(0xffa1c4fd);
Color skyBlue = Color(0xffc2e9fb);
DateTime today = DateTime.now();
String todayStr = "${today.year} ${monthList[today.month - 1]} ${today.day}";

LinearGradient gradient = LinearGradient(
  colors: [lightBlue, skyBlue],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final monthList = [
  "JAN",
  "FEB",
  "MAR",
  "APR",
  "MAY",
  "JUN",
  "JUL",
  "AUG",
  "SEP",
  "OCT",
  "NOV",
  "DEC"
];
