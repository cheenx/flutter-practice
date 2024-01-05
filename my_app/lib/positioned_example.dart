import 'package:flutter/material.dart';

Widget positionedDemo() {
  return Container(
      width: 200,
      height: 200,
      color: Colors.grey,
      child: Stack(
        children: [
          Positioned(
              left: 20, top: 20, width: 50, height: 50, child: FlutterLogo()),
          Positioned(
            left: 20,
            bottom: 20,
            child: FlutterLogo(),
          ),
          Positioned(right: 20, top: 20, child: FlutterLogo()),
          Positioned(
              left: 100, right: 20, top: 100, bottom: 20, child: FlutterLogo())
        ],
      ));
}
