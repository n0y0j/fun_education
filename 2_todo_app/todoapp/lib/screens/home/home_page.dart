import 'package:flutter/material.dart';
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
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  changePage(String page) {
    setState(() {
      pageType = page;
    });
  }
}
