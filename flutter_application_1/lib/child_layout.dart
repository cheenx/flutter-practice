import 'package:flutter/material.dart';

class ConstrainedBoxTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConstrainedBox Route'),
        backgroundColor: Colors.blue,
        actions: [
          UnconstrainedBox(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          )
        ],
      ),
      body: ConstrainedBox6(),
    );
  }
}

class ConstrainedBox1 extends StatelessWidget {
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 50.0, minWidth: double.infinity),
      child: Container(
        height: 5.0,
        child: redBox,
      ),
    );
  }
}

class ConstrainedBox2 extends StatelessWidget {
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0,
      height: 50.0,
      child: redBox,
    );
  }
}

class ConstrainedBox3 extends StatelessWidget {
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
        child: redBox,
      ),
    );
  }
}

class ConstrainedBox4 extends StatelessWidget {
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 60.0, maxHeight: 60.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 90.0, maxHeight: 30.0),
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: redBox,
        ),
      ),
    );
  }
}

class ConstrainedBox5 extends StatelessWidget {
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0),
      child: UnconstrainedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: 100.0, minHeight: 20.0),
          child: redBox,
        ),
      ),
    );
  }
}

class ConstrainedBox6 extends StatelessWidget {
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      child: AspectRatio(
        aspectRatio: 2,
        child: redBox,
      ),
    );
  }
}
