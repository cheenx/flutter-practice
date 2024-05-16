import 'package:flutter/material.dart';

class StackLayoutTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack Layout Test')),
      body: CenterTest(),
    );
  }
}

class StackTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 18.0,
            child: Text('I am Jack'),
          ),
          Container(
            color: Colors.red,
            child: Text(
              'Hello world',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            top: 18.0,
            child: Text('Your friend'),
          )
        ],
      ),
    );
  }
}

class AlignTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade50,
      child: Align(
        widthFactor: 2,
        heightFactor: 2,
        alignment: FractionalOffset(0.5, 0.5),
        child: FlutterLogo(
          size: 60.0,
        ),
      ),
    );
  }
}

class CenterTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: Text('xxx'),
      ),
    );
  }
}
