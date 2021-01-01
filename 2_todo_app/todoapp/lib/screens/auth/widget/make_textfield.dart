import 'package:flutter/material.dart';

Widget makeTextField(BuildContext context, String title, String hintText,
    Icon icon, TextEditingController controller) {
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
          obscureText: (title == "비밀번호" || title == "비밀번호 확인") ? true : false,
        ),
      ),
    ],
  );
}
