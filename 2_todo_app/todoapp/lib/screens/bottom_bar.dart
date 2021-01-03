import 'package:flutter/material.dart';

SnackBar snackBar(String text) {
  return SnackBar(
    duration: const Duration(seconds: 2),
    backgroundColor: Color(0xffEC7063),
    content: Container(
      height: 30,
      child: Row(
        children: [
          Text(text),
          Expanded(child: Container()),
          (text == "회원가입 중...")
              ? CircularProgressIndicator(
                  strokeWidth: 4.0,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Container()
        ],
      ),
    ),
  );
}
