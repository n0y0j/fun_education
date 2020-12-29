import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodaySchedule extends StatefulWidget {
  @override
  _TodayScheduleState createState() => _TodayScheduleState();
}

class _TodayScheduleState extends State<TodaySchedule> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "오늘 명희님의 일정",
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.blueAccent[100],
            ),
            SizedBox(height: 30),
            scheduleWidget(context, "모모랑 산책하기", "10:00 AM"),
            SizedBox(height: 20),
            scheduleWidget(context, "용준이랑 데이트", "13:00 PM"),
            SizedBox(height: 20),
            scheduleWidget(context, "회사 업무 마무리", "20:00 PM"),
          ],
        ),
      ),
    );
  }
}

Slidable scheduleWidget(BuildContext context, String schedule, String time) {
  return Slidable(
    actionPane: SlidableBehindActionPane(),
    actionExtentRatio: 0.3,
    child: Container(
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
                schedule,
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
    ),
    secondaryActions: [
      IconSlideAction(
        foregroundColor: Colors.white,
        caption: "Edit",
        color: Color(0xffc2e9fb),
        iconWidget: Icon(Icons.edit, color: Colors.white),
        onTap: () {},
      ),
      IconSlideAction(
        foregroundColor: Colors.white,
        caption: "Delete",
        color: Color(0xffa1c4fd),
        iconWidget: Icon(Icons.delete, color: Colors.white),
        onTap: () {},
      ),
    ],
  );
}
