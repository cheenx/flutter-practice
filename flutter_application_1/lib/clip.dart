import 'package:flutter/material.dart';

class ClipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clip Test'),
        backgroundColor: Colors.blue,
      ),
      body: ClipTest(),
    );
  }
}

class ClipTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset(
      'image/avatar.png',
      width: 60.0,
    );
    return Center(
      child: Column(
        children: [
          avatar,
          ClipOval(child: avatar),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: avatar,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5,
                child: avatar,
              ),
              Text(
                '您好，世界',
                style: TextStyle(color: Colors.green),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,
                  child: avatar,
                ),
              ),
              Text(
                "您好，世界",
                style: TextStyle(color: Colors.green),
              )
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: ClipRect(
              clipper: MyClipper(),
              child: avatar,
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
