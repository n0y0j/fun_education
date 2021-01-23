import 'package:flutter/material.dart';

Widget makeButtonDesign(BuildContext context, String text) {
  return Container(
    padding: EdgeInsets.all(10),
    width: MediaQuery.of(context).size.width * 0.7,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Color(0xee7BC4E9),
        width: 3,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
      textAlign: TextAlign.center,
    ),
  );
}
