import 'package:flutter/material.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/constants/todo_constants.dart';
import 'package:todoapp/model/people.dart';
import 'package:todoapp/screens/auth/login_page.dart';
import 'package:todoapp/screens/auth/sign_page.dart';
import 'package:todoapp/screens/home/home_page.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String nickname;

  @override
  void initState() {
    if (fa.user != null) getNickname();
    super.initState();
  }

  getNickname() async {
    String temp = await fs.getNickname(fa.user.uid);
    setState(() {
      nickname = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fa.user != null && nickname != null) {
      return HomePage(
        user: new People(nickname, fa.user.uid),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Image.asset(logoImg, height: 130),
            SizedBox(height: 30),
            Text(
              "당신의 스케줄을 적어보세요",
              style: TextStyle(fontSize: 22, color: Colors.grey[700]),
            ),
            SizedBox(height: 30),
            Text(
              "오늘 하루는 어떠셨나요?\n내일은 어떤 일이 생길까요?\n당신의 계획을 기록해보세요!",
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            Expanded(child: Container()),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200),
                  topRight: Radius.circular(200),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.22),
                  makeButton(context, '시작하기'),
                  SizedBox(height: 20),
                  makeButton(context, '로그인'),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

Widget makeButton(BuildContext context, String title) {
  return InkWell(
    onTap: () {
      (title == "시작하기")
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SignPage(),
              ),
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LoginPage(),
              ),
            );
    },
    child: Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xee7BC4E9),
          width: 3,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
