import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/constants/todo_constants.dart';
import 'package:todoapp/model/people.dart';
import 'package:todoapp/model/post.dart';
import 'package:todoapp/screens/home/widget/schedule_widget.dart';

class TodaySchedule extends StatefulWidget {
  final People user;

  const TodaySchedule({this.user});
  @override
  _TodayScheduleState createState() => _TodayScheduleState();
}

class _TodayScheduleState extends State<TodaySchedule> {
  List<Post> data;
  StreamController<List<Post>> streamController = new StreamController();

  getScheduleDate(String date) async {
    await fs
        .getSchedule(widget.user.uid, date)
        .then((value) => streamController.add(value));
  }

  @override
  void initState() {
    getScheduleDate(todayStr);
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
            Text(
              "오늘 ${widget.user.nickname}님의 일정",
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
            StreamBuilder(
                stream: streamController.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: todayScheWidget(snapshot.data, widget.user));
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

  List<Widget> todayScheWidget(List<Post> data, People user) {
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
                  deleteSchedule(user.uid, element.date, element.id);
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
