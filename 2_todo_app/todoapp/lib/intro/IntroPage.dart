import 'package:flutter/material.dart';
import 'package:todoapp/auth/auth_page.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => AuthPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 250,
          ),
        ),
      ),
    );
  }
}
