import 'package:flutter/material.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/constants/todo_constants.dart';
import 'package:todoapp/model/people.dart';
import 'package:todoapp/screens/auth/sign_page.dart';
import 'package:todoapp/screens/auth/widget/make_button.dart';
import 'package:todoapp/screens/auth/widget/make_textfield.dart';
import 'package:todoapp/screens/bottom_bar.dart';
import 'package:todoapp/screens/home/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String nickname;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailCon = new TextEditingController();
  TextEditingController passCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
              Image.asset(logoImg, height: 80),
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
              makeTextField(context, '이메일', '이메일을 입력해주세요',
                  Icon(Icons.email, color: Colors.blueAccent), emailCon),
              makeTextField(context, '비밀번호', '비밀번호를 입력해주세요',
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
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: bottomDesign,
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12),
                      InkWell(
                          onTap: () {
                            login();
                          },
                          child: makeButtonDesign(context, "입장")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    if (emailCon.text == "" || passCon.text == "")
      scaffoldKey.currentState.showSnackBar(snackBar("입력칸을 확인해주세요."));
    else {
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
  }

  getNickname() async {
    String temp = await fs.getNickname(fa.user.uid);
    setState(() {
      nickname = temp;
    });
  }
}
