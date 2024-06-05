import 'package:flutter/material.dart';

class StaggerAnimationTestRoute extends StatelessWidget {
  const StaggerAnimationTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stagger Animation Test')),
      body: StaggerRoute(),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key? key, required this.controller}) : super(key: key) {
    height = Tween<double>(begin: 0.0, end: 300.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.6, curve: Curves.ease)));

    color = ColorTween(begin: Colors.green, end: Colors.red).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.6, curve: Curves.ease)));

    padding = Tween<EdgeInsets>(
            begin: const EdgeInsets.only(left: .0),
            end: const EdgeInsets.only(left: 100.0))
        .animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 1.0, curve: Curves.ease)));
  }

  late final Animation<double> controller;
  late final Animation<double> height;
  late final Animation<EdgeInsets> padding;
  late final Animation<Color?> color;

  Widget _buildAnimation(BuildContext context, child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}

class StaggerRoute extends StatefulWidget {
  const StaggerRoute({super.key});

  @override
  State<StaggerRoute> createState() => _StaggerRouteState();
}

class _StaggerRouteState extends State<StaggerRoute>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
  }

  _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      //捕获异常，可能发生在组件销毁时，计时器会被取消
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () => _playAnimation(),
              child: Text('start animation')),
          Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                border: Border.all(color: Colors.black.withOpacity(0.5))),
            child: StaggerAnimation(controller: _controller),
          )
        ],
      ),
    );
  }
}
