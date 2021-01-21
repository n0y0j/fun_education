import 'package:flutter/material.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/constants/todo_constants.dart';
import 'package:todoapp/model/people.dart';
import 'package:todoapp/screens/bottom_bar.dart';

class NewTaskPage extends StatefulWidget {
  final People user;
  const NewTaskPage({this.user});
  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  String postDate;
  String postTime;
  int count;
  TextEditingController contentCon = new TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: gradient,
        ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Text(
                          "일정 추가하기",
                          style: TextStyle(fontSize: 22, color: Colors.black87),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "일정",
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 45,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: inputDesign,
                      child: TextField(
                        controller: contentCon,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "일정을 입력해보세요",
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 14)),
                      ),
                    ),
                    SizedBox(height: 20),
                    makeWidget("날짜", "일정을 선택하세요"),
                    SizedBox(height: 20),
                    makeWidget("시간", "시간을 선택하세요"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    InkWell(
                      onTap: () async {
                        if (postDate == null ||
                            contentCon.text == '' ||
                            postTime == null)
                          scaffoldKey.currentState
                              .showSnackBar(snackBar("입력칸을 확인해주세요."));
                        else {
                          await fs.postSchedule(widget.user.uid, postDate,
                              contentCon.text, postTime, count);

                          Navigator.pop(context, "refresh");
                        }
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
      ),
    );
  }

  Column makeWidget(String type, String hintText) {
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
              decoration: inputDesign,
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
                ? '${int.parse(selectedTime.hour.toString()) - 12}'
                : '0${int.parse(selectedTime.hour.toString()) - 12}';
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
}
