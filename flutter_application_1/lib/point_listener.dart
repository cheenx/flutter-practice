import 'package:flutter/material.dart';

class PointListenerTestRoute extends StatelessWidget {
  const PointListenerTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PointListener Test'),
      ),
      body: PointerMoveIndicatorTest1(),
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
