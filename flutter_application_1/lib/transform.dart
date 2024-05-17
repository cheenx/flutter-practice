import 'dart:math';

import 'package:flutter/material.dart';

class TransFormTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TransForm Test'),
      ),
      body: TransformTest(),
    );
  }
}

class TransformTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 50.0)),
          Container(
            color: Colors.black,
            child: Transform(
              transform: Matrix4.skewY(0.3),
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.deepOrange,
                child: const Text('Apartment for rent!'),
              ),
            ),
          ),
          Spacer(),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.translate(
              offset: Offset(-20.0, -10.0),
              child: Transform(
                transform: Matrix4.skewY(0.5),
                child: Text('Hello world'),
              ),
            ),
          ),
          Spacer(),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform(
              transform: Matrix4.skewY(0.5),
              child: Transform.translate(
                offset: Offset(-20.0, -10.0),
                child: Text('Hello world'),
              ),
            ),
          ),
          Spacer(),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.rotate(
              angle: pi / 2,
              child: Text('Hello world'),
            ),
          ),
          Spacer(),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.scale(
              scale: 1.5,
              child: Text('Hello world'),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Transform.scale(
                  scale: 1.5,
                  child: Text('Hello world'),
                ),
              ),
              Text(
                '您好',
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              )
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text('Hello world'),
                ),
              ),
              Text(
                '您好',
                style: TextStyle(color: Colors.green, fontSize: 18.0),
              )
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
