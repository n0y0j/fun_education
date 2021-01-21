import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/constants/todo_constants.dart';
import 'package:todoapp/model/people.dart';
import 'package:todoapp/model/post.dart';
import 'package:todoapp/screens/home/newtask_page.dart';
import 'package:todoapp/screens/home/widget/schedule_widget.dart';

class CalendarPage extends StatefulWidget {
  final People user;

  const CalendarPage({Key key, this.user}) : super(key: key);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController controller = new CalendarController();
  DateTime selectedDay;
  String date;
  StreamController<List<Post>> streamController = new StreamController();

  getScheduleDate(String date) async {
    await fs
        .getSchedule(widget.user.uid, date)
        .then((value) => streamController.add(value));
  }

  @override
  void initState() {
    date = todayStr;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getScheduleDate(date);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              onDaySelected: _onDaySelected,
              calendarController: controller,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              initialCalendarFormat: CalendarFormat.week,
            ),
            SizedBox(height: 30),
            Text(date, style: TextStyle(fontSize: 22, color: Colors.grey[600])),
            SizedBox(height: 20),
            StreamBuilder(
                stream: streamController.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: calendarScheWidget(
                            context, snapshot.data, widget.user));
                  } else
                    return Container();
                }),
            Center(
              child: InkWell(
                onTap: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          NewTaskPage(user: widget.user),
                    ),
                  );

                  if (result == "refresh") setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color(0xfff96060),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    setState(() {
      selectedDay = day;
      date =
          "${selectedDay.year} ${monthList[selectedDay.month - 1]} ${selectedDay.day}";
    });
  }

  deleteSchedule(String uid, String date, String id) async {
    await fs.deleteSchedule(uid, date, id);
    setState(() {});
  }

  List<Widget> calendarScheWidget(
      BuildContext context, List<Post> data, People user) {
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
