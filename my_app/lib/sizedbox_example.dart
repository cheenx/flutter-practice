import 'package:flutter/material.dart';

Widget sizedBoxDemo() {
  return const SizedBox(
    width: 50,
    height: 50,
    child: FlutterLogo(),
  );
}

Widget sizeBoxShowDemo(_show) {
  return _show ? const FlutterLogo() : const SizedBox();
}

Widget sizeBoxPlaceholder() {
  return const SizedBox(
      width: double.infinity, height: 50, child: Placeholder());
}

Widget sizeBoxTestDemo() {
  return Container(
    width: 400,
    height: 400,
    color: Colors.grey,
    child: const SizedBox(
      width: 100,
      height: 100,
      child: FlutterLogo(),
    ),
  );
}
