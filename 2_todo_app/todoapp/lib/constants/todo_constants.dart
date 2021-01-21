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

BoxDecoration bottomDesign = BoxDecoration(
  gradient: gradient,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(200),
    topRight: Radius.circular(200),
  ),
);

BoxDecoration inputDesign = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 5,
    )
  ],
  border: Border.all(
    color: Color(0xee7BC4E9),
    width: 1,
  ),
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
