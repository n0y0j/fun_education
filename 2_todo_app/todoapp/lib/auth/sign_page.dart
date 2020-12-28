import 'package:flutter/material.dart';

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
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
      body: Column(
        children: [
          Image.asset('assets/images/logo.png', height: 80),
          makeTextField('이메일', '이메일을 입력해주세요',
              Icon(Icons.email, color: Colors.blueAccent)),
          makeTextField('닉네임', '닉네임을 입력해주세요',
              Icon(Icons.person, color: Colors.blueAccent)),
          makeTextField('비밀번호', '비밀번호를 입력해주세요',
              Icon(Icons.https, color: Colors.blueAccent)),
          makeTextField('비밀번호 확인', '비밀번호를 입력해주세요',
              Icon(Icons.https, color: Colors.blueAccent)),
          Expanded(child: Container()),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignPage(),
                        ),
                      );
                    },
                    child: Text(
                      "회원가입",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget makeTextField(String title, String hintText, Icon icon) {
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
