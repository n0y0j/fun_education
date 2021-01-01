import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/firebase/fire_store.dart';

import 'package:todoapp/model/people.dart';
import 'package:todoapp/model/post.dart';
import 'package:todoapp/screens/home/home_page.dart';

List<Widget> scheduleWidget(
    BuildContext context, List<Post> data, People user) {
  FireStore fs = new FireStore();
  List<Widget> result = List<Widget>();

  deleteSchedule(String uid, String date, String id) async {
    await fs.deleteSchedule(uid, date, id);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => HomePage(
          user: user,
          pageType: "schedule",
        ),
      ),
    );
  }

  data.forEach((element) {
    result.add(
      Column(
        children: [
          Slidable(
            actionPane: SlidableBehindActionPane(),
            actionExtentRatio: 0.3,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffa1c4fd),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.content,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      SizedBox(height: 5),
                      Text(
                        element.time,
                        style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: 9,
                    decoration: BoxDecoration(
                      color: Color(0xffc2e9fb),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  )
                ],
              ),
            ),
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
      ),
    );
  });

  return result;
}