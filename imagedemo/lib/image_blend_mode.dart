import 'package:flutter/material.dart';

Widget imageBlendModeDemo() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        "images/dog.jpeg",
        height: 200,
        width: 200,
        color: Colors.white,
        colorBlendMode: BlendMode.softLight,
      ),
      Image.asset(
        "images/dog.jpeg",
        height: 200,
        width: 200,
        color: Colors.black,
        colorBlendMode: BlendMode.softLight,
      )
    ],
  );
}
