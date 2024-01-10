import 'package:flutter/material.dart';

Widget iconBackgroundDemo() {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0), color: Colors.red),
    child: Icon(
      Icons.star,
      color: Colors.white,
    ),
  );
}
