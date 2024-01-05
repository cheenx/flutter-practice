import 'package:flutter/material.dart';

Widget textAlignDemo() {
  return Column(
    children: [
      Container(
        color: Colors.grey[400],
        child: Text("末尾对齐", textAlign: TextAlign.end),
      ),
      Container(
        width: 300,
        color: Colors.grey[400],
        child: Text(
          "末尾对齐",
          textAlign: TextAlign.end,
        ),
      )
    ],
  );
}
