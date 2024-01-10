import 'package:flutter/material.dart';

Widget iconTheme() {
  return IconTheme(
      data: IconThemeData(
        size: 48,
        color: Colors.grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.close),
          Icon(
            Icons.arrow_back,
            size: 24,
          ),
          Icon(
            Icons.star,
            color: Colors.black,
          )
        ],
      ));
}
