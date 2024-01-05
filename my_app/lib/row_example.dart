import 'package:flutter/material.dart';

Widget rowDemo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FlutterLogo(),
      const SizedBox(
        width: 20,
      ),
      FlutterLogo(),
      FlutterLogo()
    ],
  );
}
