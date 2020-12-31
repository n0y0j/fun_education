import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoapp/home/widget/schedule_widget.dart';
import 'package:todoapp/model/people.dart';

class CalendarPage extends StatefulWidget {
  final People user;

  const CalendarPage({Key key, this.user}) : super(key: key);
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController controller = new CalendarController();
  DateTime today = DateTime.now();
  DateTime selectedDay;
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
            Text("${today.year} ${monthList[today.month - 1]} ${today.day}",
                style: TextStyle(fontSize: 22, color: Colors.grey[600])),
            SizedBox(height: 20),
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

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      selectedDay = day;
      print(selectedDay);
    });
  }
}
