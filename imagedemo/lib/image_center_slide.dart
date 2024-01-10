import 'package:flutter/cupertino.dart';

Widget imageCenterSlideDemo() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        "images/button.png",
        height: 100,
        width: 350,
        centerSlice: Rect.fromLTRB(20, 20, 40, 40),
      ),
      Image.asset(
        "images/button.png",
        height: 100,
        width: 350,
        fit: BoxFit.fill,
      )
    ],
  );
}
