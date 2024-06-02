import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GestureDetectorTestRoute extends StatelessWidget {
  const GestureDetectorTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gesture Detector Test')),
      body: GestureRecognizer(),
    );
  }
}

class GestureTest extends StatefulWidget {
  const GestureTest({super.key});

  @override
  State<GestureTest> createState() => _GestureTestState();
}

class _GestureTestState extends State<GestureTest> {
  String _operation = 'No Gesture detected';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 200.0,
          height: 100.0,
          child: Text(
            _operation,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () => updateText('Tap'),
        onDoubleTap: () => updateText('DoubleTap'),
        onLongPress: () => updateText('LongPress'),
      ),
    );
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}

class GestureTest1 extends StatefulWidget {
  const GestureTest1({super.key});

  @override
  State<GestureTest1> createState() => _GestureTest1State();
}

class _GestureTest1State extends State<GestureTest1> {
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
              onPanDown: (details) => print('用户手指按下：${details.globalPosition}'),
              onPanUpdate: (details) => setState(
                () {
                  _left += details.delta.dx;
                  _top += details.delta.dy;
                },
              ),
              onPanEnd: (details) => print(details.velocity),
            ))
      ],
    );
  }
}

class DragVertical extends StatefulWidget {
  const DragVertical({super.key});

  @override
  State<DragVertical> createState() => _DragVerticalState();
}

class _DragVerticalState extends State<DragVertical> {
  double _top = 0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: _top,
            child: GestureDetector(
              child: CircleAvatar(child: Text('A')),
              onVerticalDragUpdate: (details) {
                setState(() {
                  _top += details.delta.dy;
                });
              },
            ))
      ],
    );
  }
}

class ScaleTest extends StatefulWidget {
  const ScaleTest({super.key});

  @override
  State<ScaleTest> createState() => _ScaleTestState();
}

class _ScaleTestState extends State<ScaleTest> {
  double _width = 200.0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Image.asset(
          'image/sea.png',
          width: _width,
        ),
        onScaleUpdate: (details) {
          setState(() {
            _width = 200 * details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}

class GestureRecognizer extends StatefulWidget {
  const GestureRecognizer({super.key});

  @override
  State<GestureRecognizer> createState() => _GestureRecognizerState();
}

class _GestureRecognizerState extends State<GestureRecognizer> {
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(text: '你好世界'),
        TextSpan(
            text: '点我变色',
            style: TextStyle(
                fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
            recognizer: _tapGestureRecognizer
              ..onTap = () {
                setState(() {
                  _toggle = !_toggle;
                });
              }),
        TextSpan(text: '你好世界')
      ])),
    );
  }
}
