import 'package:flutter/material.dart';

//熟悉decoration属性 和 foregrounddecoration属性
Widget decorationDemo(BuildContext context) {
  return Container(
    width: 100,
    height: 100,
    decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Colors.black, Colors.grey]),
        boxShadow: [BoxShadow(blurRadius: 10)]),
    alignment: Alignment.center,
    foregroundDecoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.5),
      shape: BoxShape.circle,
    ),
    transform: Matrix4(1.06, 0.53, 0.00, 0.00, -1.06, 0.53, 0.00, 0.00, 0.00,
        0.00, 1.50, 0.00, 0.00, 0.00, 0.00, 1.00),
    child: Container(
      color: Colors.white,
      width: 50,
      height: 50,
    ),
  );
}
