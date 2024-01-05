import 'package:flutter/material.dart';

Widget columnDemo() {
  return Container(
    color: Colors.grey.withOpacity(0.5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      verticalDirection: VerticalDirection.down,
      children: [
        Container(width: 200, height: 30, color: Colors.grey),
        const FlutterLogo(size: 30),
        Container(width: 200, height: 30, color: Colors.black),
        const SizedBox(width: 200, height: 30),
        Container(width: 200, height: 30, color: Colors.grey)
      ],
    ),
  );
}
