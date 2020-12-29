import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoapp/home/widget/schedule_widget.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController controller = new CalendarController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              calendarController: controller,
              startingDayOfWeek: StartingDayOfWeek.sunday,
              initialCalendarFormat: CalendarFormat.week,
            ),
            SizedBox(height: 30),
            Text("2020 DEC 29",
                style: TextStyle(fontSize: 22, color: Colors.grey[600])),
            SizedBox(height: 20),
            scheduleWidget(context, "모모랑 산책하기", "10:00 AM"),
            SizedBox(height: 20),
            scheduleWidget(context, "용준이랑 데이트", "13:00 PM"),
            SizedBox(height: 20),
            scheduleWidget(context, "회사 업무 마무리", "20:00 PM"),
            SizedBox(height: 30),
            Center(
              child: InkWell(
                child: Container(
                  height: 100,
                  width: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xfff96060), Colors.red],
                    ),
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
}
