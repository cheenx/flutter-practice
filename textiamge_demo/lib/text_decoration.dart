import 'dart:math';

import 'package:flutter/material.dart';

Widget textDecorationDemo() {
  return Column(
    children: [
      Text(
        "这是一行被划掉的文字",
        style: TextStyle(
            decoration: TextDecoration.lineThrough,
            decorationColor: Colors.black,
            decorationStyle: TextDecorationStyle.solid,
            decorationThickness: 4),
      ),
      Text(
        "一行有下面波浪线的文字",
        style: TextStyle(
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.wavy,
            decorationColor: Colors.grey[600],
            decorationThickness: 2),
      )
    ],
  );
}
