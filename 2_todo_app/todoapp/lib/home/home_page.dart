import 'package:flutter/material.dart';
import 'package:todoapp/home/today_schedule.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    gradient: LinearGradient(
                      colors: [Color(0xffa1c4fd), Color(0xffc2e9fb)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
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
                        Text(
                          "오늘의 일정",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        Center(
                            child: Container(
                                width: 2, height: 22, color: Colors.white)),
                        Text(
                          "계획 세우기",
                          style:
                              TextStyle(color: Colors.grey[300], fontSize: 17),
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
              child: TodaySchedule(),
            ),
          ),
        ],
      ),
    );
  }
}
