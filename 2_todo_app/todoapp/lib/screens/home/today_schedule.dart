import 'package:flutter/material.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/constants/todo_constants.dart';

import 'package:todoapp/firebase/fire_store.dart';

import 'package:todoapp/model/people.dart';
import 'package:todoapp/model/post.dart';
import 'package:todoapp/screens/home/widget/schedule_widget.dart';

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

  getScheduleDate() async {
    await fs.getSchedule(widget.user.uid, todayStr);

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
                : Column(children: todayScheWidget(context, data, widget.user))
          ],
        ),
      ),
    );
  }
}
