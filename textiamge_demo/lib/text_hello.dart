import 'package:flutter/material.dart';

Widget StackText() {
  return Stack(
    children: [
      Text(
        "文字镂空效果",
        style: TextStyle(
            fontSize: 40,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = Colors.black),
      ),
      Text(
        "文字镂空效果",
        style: TextStyle(fontSize: 40, color: Colors.grey),
      )
    ],
  );
}
