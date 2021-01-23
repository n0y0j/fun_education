import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/model/post.dart';
import 'package:todoapp/utils/constants/db_constants.dart';
import 'package:todoapp/utils/constants/todo_constants.dart';
import 'package:todoapp/utils/schedule_widget.dart';

class TodaySchedule extends StatefulWidget {
  @override
  _TodayScheduleState createState() => _TodayScheduleState();
}

class _TodayScheduleState extends State<TodaySchedule> {
  List<Post> data;
  StreamController<List<Post>> streamController = new StreamController();
  StreamController<String> nickStreamController = new StreamController();

  getScheduleDate(String date) async {
    await fs
        .getSchedule(fa.user.uid, date)
        .then((value) => streamController.add(value));
  }

  getNickName() async {
    await fs
        .getNickname(fa.user.uid)
        .then((value) => nickStreamController.add(value));
  }

  @override
  void initState() {
    getScheduleDate(todayStr);
    getNickName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getScheduleDate(todayStr);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: nickStreamController.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "오늘 ${snapshot.data}님의 일정",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey[800],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(height: 10),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.blueAccent[100],
            ),
            SizedBox(height: 30),
            StreamBuilder(
                stream: streamController.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: todayScheWidget(snapshot.data));
                  } else
                    return Container();
                })
          ],
        ),
      ),
    );
  }

  deleteSchedule(String uid, String date, String id) async {
    await fs.deleteSchedule(uid, date, id);
    setState(() {});
  }

  List<Widget> todayScheWidget(List<Post> data) {
    List<Widget> result = List<Widget>();

    data.forEach((element) {
      result.add(Column(
        children: [
          Slidable(
            actionPane: SlidableBehindActionPane(),
            actionExtentRatio: 0.3,
            child: scheWidget(context, element.content, element.time),
            secondaryActions: [
              IconSlideAction(
                foregroundColor: Colors.white,
                caption: "Delete",
                color: Color(0xffc2e9fb),
                iconWidget: Icon(Icons.delete, color: Colors.white),
                onTap: () {
                  deleteSchedule(fa.user.uid, element.date, element.id);
                },
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ));
    });

    return result;
  }
}
