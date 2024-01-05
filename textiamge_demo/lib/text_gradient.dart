import 'package:flutter/material.dart';
import 'dart:ui' as ui;

Widget textGradientDemo() {
  return Text("颜色渐变",
      style: TextStyle(
          fontSize: 48,
          background: Paint()
            ..shader = ui.Gradient.linear(
              Offset.zero,
              Offset(150, 0),
              [Colors.black, Colors.white],
            ),
          foreground: Paint()
            ..shader = ui.Gradient.linear(
                Offset(0, 100), Offset(0, 180), [Colors.white, Colors.black])));
}
