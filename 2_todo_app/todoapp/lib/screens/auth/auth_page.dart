import 'package:flutter/material.dart';
import 'package:todoapp/model/people.dart';
import 'package:todoapp/screens/auth/login_page.dart';
import 'package:todoapp/screens/auth/sign_page.dart';
import 'package:todoapp/screens/home/home_page.dart';
import 'package:todoapp/utils/constants/db_constants.dart';
import 'package:todoapp/utils/constants/todo_constants.dart';
import 'package:todoapp/utils/make_button.dart';

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
    nickname = await fs.getNickname(fa.user.uid);
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
              decoration: bottomDesign,
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
    child: makeButtonDesign(context, title),
  );
}
