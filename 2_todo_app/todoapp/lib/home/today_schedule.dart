import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/firebase/fire_store.dart';
import 'package:todoapp/home/widget/schedule_widget.dart';
import 'package:todoapp/model/people.dart';
import 'package:todoapp/model/post.dart';

class TodaySchedule extends StatefulWidget {
  final People user;

  const TodaySchedule({Key key, this.user}) : super(key: key);
  @override
  _TodayScheduleState createState() => _TodayScheduleState();
}

class _TodayScheduleState extends State<TodaySchedule> {
  String nickname;
  String uid;
  List<Post> data;
  FireStore fs = new FireStore();
  DateTime today = DateTime.now();
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

  getScheduleDate() async {
    await fs.getSchedule(widget.user.uid,
        "${today.year} ${monthList[today.month - 1]} ${today.day}");

    setState(() {
      data = fs.getData();
    });
  }

  @override
  void initState() {
    nickname = widget.user.nickname;
    uid = widget.user.uid;

    getScheduleDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "오늘 $nickname님의 일정",
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
            (data == null)
                ? Container()
                : Column(children: scheduleWidget(context, data, widget.user))
          ],
        ),
      ),
    );
  }
}
