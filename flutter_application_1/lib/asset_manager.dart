import 'package:flutter/material.dart';

class AssetsTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Assets Manager'),
        ),
        body: Center(child: Image.asset('image/avatar.png')));
  }
}
