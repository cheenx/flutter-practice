import 'package:flutter/material.dart';

Widget imageFitDemo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Image.asset(
        "images/dog.jpeg",
        height: 300,
        width: 100,
        fit: BoxFit.fill,
      ),
      Container(
        color: Colors.grey,
        child: Image.asset(
          "images/dog.jpeg",
          height: 300,
          width: 100,
          fit: BoxFit.contain,
        ),
      ),
      Image.asset(
        "images/dog.jpeg",
        height: 300,
        width: 100,
        fit: BoxFit.cover,
      )
    ],
  );
}

Widget imageFitRepeatDemo() {
  return Image.asset(
    "images/dog.jpeg",
    height: 100,
    width: 350,
    alignment: Alignment.centerLeft,
    repeat: ImageRepeat.repeat,
  );
}
