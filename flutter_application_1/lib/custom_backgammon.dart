import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_widget.dart';

class CustomBackgammonTestRoute extends StatelessWidget {
  const CustomBackgammonTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Backgammon Test')),
      body: GradientCircularProgressRoute(),
    );
  }
}

class CustomPaintRoute extends StatelessWidget {
  const CustomPaintRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              RepaintBoundary(
                child: CustomPaint(
                  size: Size(300.0, 300.0),
                  painter: MyPainter(),
                ),
              ),
              CustomPaint(
                size: Size(300, 300),
                painter: PiecesPainter(),
              )
            ],
          ),
          ElevatedButton(onPressed: () {}, child: const Text('刷新'))
        ],
      ),
    );
  }
}

class PiecesPainter extends CustomPainter {
  PiecesPainter({Listenable? repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    print('print pieces');

    var rect = Offset.zero & size;

    //画棋子
    drawPieces(canvas, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('paint');
    var rect = Offset.zero & size;
    //画棋盘
    drawChessboard(canvas, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void drawChessboard(Canvas canvas, Rect rect) {
  //棋盘背景
  var paint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..color = Color(0xFFDCC48C);

  canvas.drawRect(rect, paint);

  paint
    ..style = PaintingStyle.stroke
    ..color = Colors.black38
    ..strokeWidth = 1.0;

  for (var i = 0; i <= 15; ++i) {
    double dy = rect.top + rect.height / 15 * i;
    canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
  }

  for (var i = 0; i <= 15; ++i) {
    double dx = rect.left + rect.width / 15 * i;
    canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
  }
}

void drawPieces(Canvas canvas, Rect rect) {
  double eWidth = rect.width / 15;
  double eHeight = rect.height / 15;

  var paint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.black;

  //画一个黑子
  canvas.drawCircle(
      Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint);

  //画一个白子
  paint.color = Colors.white;
  canvas.drawCircle(
      Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint);
}

class GradientCircularProgressIndicator extends StatelessWidget {
  const GradientCircularProgressIndicator({
    Key? key,
    this.strokeWidth = 2.0,
    required this.radius,
    required this.colors,
    this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = 2 * pi,
    this.value,
  }) : super(key: key);

  final double strokeWidth;
  final double radius;
  final bool strokeCapRound;
  final double? value;
  final Color backgroundColor;
  final double totalAngle;
  final List<Color> colors;
  final List<double>? stops;

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).colorScheme.secondary;
      _colors = [color, color];
    }

    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
            strokeWidth: strokeWidth,
            strokeCapRound: strokeCapRound,
            backgroundColor: backgroundColor,
            value: value,
            total: totalAngle,
            radius: radius,
            colors: _colors),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter({
    this.strokeWidth = 10.0,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.radius,
    this.total = 2 * pi,
    @required this.colors,
    this.stops,
    this.value,
  });

  final double strokeWidth;
  final bool strokeCapRound;
  final double? value;
  final Color backgroundColor;
  final List<Color>? colors;
  final double total;
  final double? radius;
  final List<double>? stops;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius ?? .0);
    }

    double _offset = strokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    if (_value > 0) {
      paint.shader = SweepGradient(
              colors: colors!, startAngle: 0.0, endAngle: _value, stops: stops)
          .createShader(rect);
      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  //简单返回true，实践中应该根据画笔属性是否变化来确定返回true 还是false
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GradientCircularProgressRoute extends StatefulWidget {
  const GradientCircularProgressRoute({super.key});

  @override
  State<GradientCircularProgressRoute> createState() =>
      _GradientCircularProgressRouteState();
}

class _GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: [
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            strokeWidth: 3.0,
                            colors: const [Colors.blue, Colors.blue],
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            strokeWidth: 3.0,
                            colors: const [Colors.red, Colors.orange],
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            strokeWidth: 5.0,
                            colors: const [
                              Colors.red,
                              Colors.orange,
                              Colors.red
                            ],
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            strokeWidth: 5.0,
                            colors: const [
                              Colors.teal,
                              Colors.cyan,
                            ],
                            value: CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.decelerate)
                                .value,
                          ),
                          TurnBox(
                            turns: 1 / 8,
                            child: GradientCircularProgressIndicator(
                              radius: 50.0,
                              strokeWidth: 3.0,
                              strokeCapRound: true,
                              backgroundColor: Colors.red.shade50,
                              totalAngle: 1.5 * pi,
                              colors: const [Colors.red, Colors.orange],
                              value: CurvedAnimation(
                                      parent: _animationController,
                                      curve: Curves.ease)
                                  .value,
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: GradientCircularProgressIndicator(
                              radius: 50.0,
                              strokeWidth: 3.0,
                              colors: [
                                Colors.blue.shade700,
                                Colors.blue.shade200
                              ],
                              backgroundColor: Colors.transparent,
                              value: _animationController.value,
                            ),
                          ),
                          GradientCircularProgressIndicator(
                            radius: 50.0,
                            colors: [
                              Colors.red,
                              Colors.amber,
                              Colors.cyan,
                              Colors.green.shade200,
                              Colors.blue,
                              Colors.red
                            ],
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            radius: 100.0,
                            colors: [
                              Colors.blue.shade700,
                              Colors.blue.shade200
                            ],
                            strokeWidth: 20.0,
                            value: _animationController.value,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: GradientCircularProgressIndicator(
                              radius: 100.0,
                              colors: [
                                Colors.blue.shade700,
                                Colors.blue.shade200
                              ],
                              strokeWidth: 20.0,
                              strokeCapRound: true,
                              value: _animationController.value,
                            ),
                          ),
                          ClipRect(
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: .5,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  child: TurnBox(
                                    turns: .75,
                                    child: GradientCircularProgressIndicator(
                                      colors: [
                                        Colors.teal,
                                        Colors.cyan.shade500
                                      ],
                                      radius: 100.0,
                                      strokeWidth: 8.0,
                                      value: _animationController.value,
                                      totalAngle: pi,
                                      strokeCapRound: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 104.0,
                            width: 200.0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                    height: 200.0,
                                    top: .0,
                                    child: TurnBox(
                                      turns: .75,
                                      child: GradientCircularProgressIndicator(
                                        colors: [
                                          Colors.teal,
                                          Colors.cyan.shade500
                                        ],
                                        radius: 100.0,
                                        strokeWidth: 8.0,
                                        value: _animationController.value,
                                        totalAngle: pi,
                                        strokeCapRound: true,
                                      ),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(top: 30.0),
                                  child: Text(
                                    '${((_animationController.value * 1000) / 10).toInt()}%',
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.blueGrey),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
        ],
      )),
    );
  }
}
