import 'package:flutter/material.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/constants/todo_constants.dart';
import 'package:todoapp/model/people.dart';
import 'package:todoapp/screens/home/calendar_page.dart';
import 'package:todoapp/screens/home/today_schedule.dart';

class HomePage extends StatefulWidget {
  final People user;

  const HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String pageType = "today";
  bool click = false;
  TextEditingController contentCon = new TextEditingController();
  String postDate;
  String postTime;
  int count;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.075),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            changePage('today');
                          },
                          child: Text(
                            "오늘의 일정",
                            style: (pageType == 'today')
                                ? TextStyle(color: Colors.white, fontSize: 17)
                                : TextStyle(
                                    color: Colors.grey[300], fontSize: 17),
                          ),
                        ),
                        Center(
                            child: Container(
                                width: 2, height: 22, color: Colors.white)),
                        InkWell(
                          onTap: () {
                            changePage('schedule');
                          },
                          child: Text(
                            "계획 세우기",
                            style: (pageType == 'schedule')
                                ? TextStyle(color: Colors.white, fontSize: 17)
                                : TextStyle(
                                    color: Colors.grey[300], fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(1, 5),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      (pageType == "today")
                          ? TodaySchedule(user: widget.user)
                          : CalendarPage(user: widget.user),
                      (pageType == "schedule")
                          ? Center(
                              child: InkWell(
                                onTap: () {
                                  changeClick();
                                },
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
                          : Container(),
                    ],
                  ),
                )),
          ),
          (click)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "일정 추가하기",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.black87),
                                ),
                              ),
                              SizedBox(height: 40),
                              Text(
                                "일정",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey[600]),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: 45,
                                padding: EdgeInsets.only(
                                    top: 4, left: 16, right: 16, bottom: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                    )
                                  ],
                                  border: Border.all(
                                    color: Color(0xee7BC4E9),
                                    width: 1,
                                  ),
                                ),
                                child: TextField(
                                  controller: contentCon,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "일정을 입력해보세요",
                                      hintStyle: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 14)),
                                ),
                              ),
                              SizedBox(height: 20),
                              makeWidget("날짜", "일정을 선택하세요"),
                              SizedBox(height: 20),
                              makeWidget("시간", "시간을 선택하세요"),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1),
                              InkWell(
                                onTap: () {
                                  postSchedule(widget.user.uid, postDate,
                                      contentCon.text, postTime, count);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Color(0xffff96060),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "일정 추가",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  postSchedule(
      String uid, String date, String content, String time, int count) async {
    await fs.postSchedule(
        widget.user.uid, postDate, contentCon.text, postTime, count);

    setState(() {
      contentCon.clear();
      postDate = null;
      postTime = null;
      click = false;
    });
  }

  changePage(String page) {
    setState(() {
      pageType = page;
    });
  }

  changeClick() {
    setState(() {
      click = !(click);
    });
  }

  Column makeWidget(String type, String hintText) {
    setTime() async {
      TimeOfDay selectedTime = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      );

      String timeType = (selectedTime.hour < 12) ? 'AM' : 'PM';
      String hour = (selectedTime.hour < 10)
          ? '0${selectedTime.hour}'
          : (selectedTime.hour < 13)
              ? selectedTime.hour.toString()
              : (selectedTime.hour < 20)
                  ? '0${int.parse(selectedTime.hour.toString()) - 12}'
                  : '${int.parse(selectedTime.hour.toString()) - 12}';
      String minute = (selectedTime.minute.toString().length == 1)
          ? '0${selectedTime.minute}'
          : selectedTime.minute.toString();

      setState(() {
        postTime = '${hour}:${minute} ${timeType}';
        count = (selectedTime.hour * 60) + (selectedTime.minute);
      });
    }

    setDate() async {
      DateTime selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light(),
            child: child,
          );
        },
      );

      setState(() {
        postDate =
            "${selectedDate.year} ${monthList[selectedDate.month - 1]} ${selectedDate.day}";
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: TextStyle(fontSize: 15, color: Colors.grey[600]),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: 45,
              decoration: BoxDecoration(
                color: Color(0xee7BC4E9),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                  )
                ],
              ),
              child: FlatButton(
                onPressed: () {
                  (type == "날짜") ? setDate() : setTime();
                },
                child: Text(
                  "선택",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            SizedBox(width: 5),
            Container(
              width: MediaQuery.of(context).size.width * 0.525,
              height: 45,
              padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                  )
                ],
                border: Border.all(
                  color: Color(0xee7BC4E9),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  (type == "날짜" && postDate != null)
                      ? postDate
                      : (type == "시간" && postTime != null)
                          ? postTime
                          : hintText,
                  style: (type == "날짜" && postDate != null)
                      ? TextStyle(color: Colors.black87, fontSize: 14)
                      : (type == "시간" && postTime != null)
                          ? TextStyle(color: Colors.black87, fontSize: 14)
                          : TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
