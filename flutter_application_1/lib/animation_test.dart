import 'package:flutter/material.dart';

class AnimationTestRoute extends StatelessWidget {
  const AnimationTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Test'),
      ),
      body: ScaleAnimationRoute1(),
    );
  }
}

class AnimationTest extends StatelessWidget {
  const AnimationTest({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleAnimationRoute();
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  const ScaleAnimationRoute({super.key});

  @override
  State<ScaleAnimationRoute> createState() => _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);

    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);

    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'image/avatar.png',
        width: animation.value,
        height: animation.value,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedImage extends AnimatedWidget {
  const AnimatedImage({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Image.asset(
        'image/avatar.png',
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class ScaleAnimationRoute1 extends StatefulWidget {
  const ScaleAnimationRoute1({super.key});

  @override
  State<ScaleAnimationRoute1> createState() => _ScaleAnimationRoute1State();
}

class _ScaleAnimationRoute1State extends State<ScaleAnimationRoute1>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedBuilder(
    //     animation: animation,
    //     child: Image.asset('image/avatar.png'),
    //     builder: (context, chiild) {
    //       return Center(
    //         child: SizedBox(
    //           height: animation.value,
    //           width: animation.value,
    //           child: chiild,
    //         ),
    //       );
    //     });

    return GrowTransition(
        child: Image.asset('image/avatar.png'), animation: animation);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({super.key, required this.animation, this.child});

  final Widget? child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: animation,
          child: child,
          builder: (context, child) {
            return SizedBox(
              width: animation.value,
              height: animation.value,
              child: child,
            );
          }),
    );
  }
}
