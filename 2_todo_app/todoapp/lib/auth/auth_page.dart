import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/auth/login_page.dart';
import 'package:todoapp/auth/sign_page.dart';
import 'package:todoapp/firebase/fire_auth.dart';
import 'package:todoapp/home/home_page.dart';
import 'package:todoapp/model/people.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  FireAuth fa = new FireAuth();
  String nickname;

  @override
  void initState() {
    if (fa.user != null) getNickname();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (fa.user != null && nickname != null) {
      return HomePage(
        user: new People(nickname, fa.user.uid),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Image.asset('assets/images/logo.png', height: 130),
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
              gradient: LinearGradient(
                colors: [Color(0xffa1c4fd), Color(0xffc2e9fb)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
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

  getNickname() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(fa.user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      setState(() {
        nickname = documentSnapshot.get('nickname');
      });
    });
  }
}

Widget makeButton(BuildContext context, String title) {
  return Container(
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
    child: InkWell(
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
      child: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
