import 'package:flutter/material.dart';

Widget alignDemo() {
  return Align(
    alignment: Alignment(-0.5, 1.0),
    child: FlutterLogo(),
  );
}

Widget alignOtherDemo() {
  return Container(
    width: 100,
    height: 100,
    color: Colors.grey[200],
    child: Align(
      alignment: Alignment(2.0, 0),
      // alignment: FractionalOffset(1.5, 0.5),
      child: FlutterLogo(
        size: 50,
      ),
    ),
  );
}

Widget alignWidthHeightDemo() {
  return Container(
    color: Colors.grey,
    child: Align(
      alignment: Alignment.center,
      widthFactor: 2.0,
      heightFactor: 0.5,
      child: FlutterLogo(size: 100),
    ),
  );
}
