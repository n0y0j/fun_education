import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/constants/todo_constants.dart';
import 'package:todoapp/model/people.dart';
import 'package:todoapp/model/post.dart';
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
  List<Post> data;

  getScheduleDate(String date) async {
    await fs.getSchedule(widget.user.uid, date);

    setState(() {
      data = fs.getData();
    });
  }

  @override
  void initState() {
    getScheduleDate(todayStr);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Text(todayStr,
                style: TextStyle(fontSize: 22, color: Colors.grey[600])),
            SizedBox(height: 20),
            (data == null)
                ? Container()
                : Column(children: scheduleWidget(context, data, widget.user))
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    setState(() {
      selectedDay = day;
      getScheduleDate(
          "${selectedDay.year} ${monthList[selectedDay.month - 1]} ${selectedDay.day}");
    });
  }
}
