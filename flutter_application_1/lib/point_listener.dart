import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/hit_test_blocker.dart';
import 'package:flutter_application_1/widgets/water_mark.dart';

class PointListenerTestRoute extends StatelessWidget {
  const PointListenerTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PointListener Test'),
      ),
      body: StackEventTest(),
    );
  }
}

class PointMoveIndicator extends StatefulWidget {
  const PointMoveIndicator({super.key});

  @override
  State<PointMoveIndicator> createState() => _PointMoveIndicatorState();
}

class _PointMoveIndicatorState extends State<PointMoveIndicator> {
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 300.0,
        height: 150.0,
        child: Text(
          '${_event?.localPosition ?? ''}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      onPointerDown: (event) => setState(() {
        _event = event;
      }),
      onPointerMove: (event) => setState(() {
        _event = event;
      }),
      onPointerUp: (event) => setState(() {
        _event = event;
      }),
    );
  }
}

class PointerMoveIndicatorTest1 extends StatefulWidget {
  const PointerMoveIndicatorTest1({super.key});

  @override
  State<PointerMoveIndicatorTest1> createState() =>
      _PointerMoveIndicatorTest1State();
}

class _PointerMoveIndicatorTest1State extends State<PointerMoveIndicatorTest1> {
  @override
  Widget build(BuildContext context) {
    return Listener(
      child: AbsorbPointer(
        child: Listener(
          child: Container(
            color: Colors.red,
            width: 200.0,
            height: 100.0,
          ),
          onPointerDown: (event) => print('in'),
        ),
      ),
      onPointerDown: (event) => print('out'),
    );
  }
}

class WaterMaskTest extends StatelessWidget {
  const WaterMaskTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        wChild(1, Colors.white, 200),
        IgnorePointer(
          child: WaterMark(
            painter: TextWaterMarkPainter(text: 'wendux', rotate: -20),
          ),
        )
      ],
    );
  }
}

Widget wChild(int index, color, double size) {
  return Listener(
    onPointerDown: (event) => print(index),
    child: Container(
      width: size,
      height: size,
      color: Colors.grey,
    ),
  );
}

class StackEventTest extends StatelessWidget {
  const StackEventTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HitTestBlocker(
          child: xChild(1),
        ),
        HitTestBlocker(
          child: xChild(2),
        )
      ],
    );
  }
}

Widget xChild(int index) {
  return Listener(
    behavior: HitTestBehavior.translucent,
    onPointerDown: (event) => print(index),
    child: Container(
      width: 100.0,
      height: 100.0,
      color: Colors.grey,
    ),
  );
}
