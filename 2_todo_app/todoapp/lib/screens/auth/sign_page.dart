import 'package:flutter/material.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/constants/todo_constants.dart';
import 'package:todoapp/screens/auth/login_page.dart';
import 'package:todoapp/screens/auth/widget/make_button.dart';
import 'package:todoapp/screens/auth/widget/make_textfield.dart';
import 'package:todoapp/screens/bottom_bar.dart';

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  TextEditingController emailCon = new TextEditingController();
  TextEditingController nickCon = new TextEditingController();
  TextEditingController passCon = new TextEditingController();
  TextEditingController repassCon = new TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
              makeTextField(context, '이메일', '이메일을 입력해주세요',
                  Icon(Icons.email, color: Colors.blueAccent), emailCon),
              makeTextField(context, '닉네임', '닉네임을 입력해주세요',
                  Icon(Icons.person, color: Colors.blueAccent), nickCon),
              makeTextField(context, '비밀번호', '비밀번호를 입력해주세요',
                  Icon(Icons.https, color: Colors.blueAccent), passCon),
              makeTextField(context, '비밀번호 확인', '비밀번호를 입력해주세요',
                  Icon(Icons.https, color: Colors.blueAccent), repassCon),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                            scaffoldKey.currentState
                                .showSnackBar(snackBar("회원가입 중..."));
                            signup();
                          },
                          child: makeButtonDesign(context, "회원가입")),
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

  signup() async {
    if (emailCon.text == '' ||
        nickCon.text == '' ||
        passCon.text == '' ||
        repassCon.text == '')
      scaffoldKey.currentState.showSnackBar(snackBar("입력칸을 확인해주세요."));
    else if (passCon.text != repassCon.text)
      scaffoldKey.currentState.showSnackBar(snackBar("입력된 패스워드가 다릅니다."));
    else {
      await fa.registerUser(
          emailCon.text, nickCon.text, passCon.text, repassCon.text);

      Future.delayed(Duration(seconds: 2), () {
        snackBar("회원가입이 완료되었습니다.");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        );
      });
    }
  }
}
