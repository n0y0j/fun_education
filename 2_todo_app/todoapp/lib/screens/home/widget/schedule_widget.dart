import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/model/people.dart';
import 'package:todoapp/model/post.dart';
import 'package:todoapp/screens/home/home_page.dart';

List<Widget> calendarScheWidget(
    BuildContext context, List<Post> data, People user) {
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

List<Widget> todayScheWidget(
    BuildContext context, List<Post> data, People user) {
  List<Widget> result = List<Widget>();

  data.forEach((element) {
    result.add(Column(
      children: [
        scheWidget(context, element.content, element.time),
        SizedBox(height: 20),
      ],
    ));
  });

  return result;
}

Container scheWidget(BuildContext context, String content, String time) {
  return Container(
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
              content,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 5),
            Text(
              time,
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
  );
}
