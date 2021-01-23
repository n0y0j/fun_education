import 'package:flutter/material.dart';

Container scheWidget(BuildContext context, String content, String time) {
  return Container(
    height: 60,
    width: MediaQuery.of(context).size.width * 0.8,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xffa1c4fd),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(fontSize: 15, color: Colors.grey[500]),
            ),
          ],
        ),
        Expanded(child: Container()),
        Container(
          height: MediaQuery.of(context).size.height,
          width: 9,
          decoration: BoxDecoration(
            color: Color(0xffc2e9fb),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        )
      ],
    ),
  );
}
