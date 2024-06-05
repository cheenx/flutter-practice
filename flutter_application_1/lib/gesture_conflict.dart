import 'package:flutter/material.dart';

class GestureConflictTestRoute extends StatelessWidget {
  const GestureConflictTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Conflict Test'),
      ),
      body: GestureConflictTest1(),
    );
  }
}

class GestureConflictTest extends StatelessWidget {
  const GestureConflictTest({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) => print('2'),
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.red,
        alignment: Alignment.center,
        child: GestureDetector(
          onTapUp: (details) => print('1'),
          child: Container(
            width: 50.0,
            height: 50.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class BothDirectionTest extends StatefulWidget {
  const BothDirectionTest({super.key});

  @override
  State<BothDirectionTest> createState() => _BothDirectionTestState();
}

class _BothDirectionTestState extends State<BothDirectionTest> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(child: Text('A')),
              onVerticalDragUpdate: (details) {
                setState(() {
                  _top += details.delta.dy;
                });
              },
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _left += details.delta.dx;
                });
              },
            ))
      ],
    );
  }
}

class GestureConflictTest1 extends StatefulWidget {
  const GestureConflictTest1({super.key});

  @override
  State<GestureConflictTest1> createState() => _GestureConflictTest1State();
}

class _GestureConflictTest1State extends State<GestureConflictTest1> {
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            left: _left,
            child: Listener(
              onPointerDown: (event) {
                print('down');
              },
              onPointerUp: (event) {
                print('up');
              },
              child: GestureDetector(
                  child: CircleAvatar(
                    child: Text('A'),
                  ),
                  onHorizontalDragUpdate: (details) {
                    print('onHorizontalDragUpdate');
                    setState(() {
                      _left += details.delta.dx;
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    print('onHorizontalDragEnd');
                  }),
            ))
      ],
    );
  }
}
