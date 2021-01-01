import 'package:flutter/material.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/constants/todo_constants.dart';
import 'package:todoapp/screens/auth/login_page.dart';
import 'package:todoapp/screens/auth/widget/make_textfield.dart';

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  TextEditingController emailCon = new TextEditingController();
  TextEditingController nickCon = new TextEditingController();
  TextEditingController passCon = new TextEditingController();
  TextEditingController repassCon = new TextEditingController();

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
              Image.asset(logoImg, height: 80),
              makeTextField(context, '이메일', '이메일을 입력해주세요',
                  Icon(Icons.email, color: Colors.blueAccent), emailCon),
              makeTextField(context, '닉네임', '닉네임을 입력해주세요',
                  Icon(Icons.person, color: Colors.blueAccent), nickCon),
              makeTextField(context, '비밀번호', '비밀번호를 입력해주세요',
                  Icon(Icons.https, color: Colors.blueAccent), passCon),
              makeTextField(context, '비밀번호 확인', '비밀번호를 입력해주세요',
                  Icon(Icons.https, color: Colors.blueAccent), repassCon),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200),
                    topRight: Radius.circular(200),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                    InkWell(
                      onTap: () {
                        signup();
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
                          "회원가입",
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

  signup() async {
    await fa.registerUser(
        emailCon.text, nickCon.text, passCon.text, repassCon.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
    );
  }
}
