import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/auth/sign_page.dart';
import 'package:todoapp/firebase/fire_auth.dart';
import 'package:todoapp/home/home_page.dart';
import 'package:todoapp/model/people.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FireAuth fa = new FireAuth();
  String nickname;

  TextEditingController emailCon = new TextEditingController();
  TextEditingController passCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', height: 80),
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
              makeTextField('이메일', '이메일을 입력해주세요',
                  Icon(Icons.email, color: Colors.blueAccent), emailCon),
              makeTextField('비밀번호', '비밀번호를 입력해주세요',
                  Icon(Icons.https, color: Colors.blueAccent), passCon),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("계정이 없으시다면?",
                      style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignPage(),
                        ),
                      );
                    },
                    child: Text(
                      "가입하기",
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.325,
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                    Container(
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
                          login();
                        },
                        child: Text(
                          "로그인",
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    await fa.loginUser(emailCon.text, passCon.text);
    await getNickname();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => HomePage(
          user: new People(nickname, fa.user.uid),
        ),
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

  Widget makeTextField(String title, String hintText, Icon icon,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(color: Colors.black87),
        ),
        SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 45,
          padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
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
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: icon,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14)),
          ),
        ),
      ],
    );
  }
}
