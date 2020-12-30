import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/home/widget/schedule_widget.dart';
import 'package:todoapp/model/people.dart';

class TodaySchedule extends StatefulWidget {
  final People user;

  const TodaySchedule({Key key, this.user}) : super(key: key);
  @override
  _TodayScheduleState createState() => _TodayScheduleState();
}

class _TodayScheduleState extends State<TodaySchedule> {
  String nickname;
  String uid;

  @override
  void initState() {
    nickname = widget.user.nickname;
    uid = widget.user.uid;
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
