import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/slide_transition.dart';

class AnimatedSwitcherTestRoute extends StatelessWidget {
  const AnimatedSwitcherTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated Switcher Test')),
      body: AnimatedSwitcherCounterRoute(),
    );
  }
}

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  const AnimatedSwitcherCounterRoute({super.key});

  @override
  State<AnimatedSwitcherCounterRoute> createState() =>
      _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              // return ScaleTransition(
              //   scale: animation,
              //   child: child,
              // );
              var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
              return SlideTransitionX(
                position: animation,
                child: child,
                direction: AxisDirection.right,
              );
            },
            child: Text(
              '$_count',
              //显示指定Key，不同的key会被认为是不同的Text，这样才能执行动画
              key: ValueKey<int>(_count),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          ElevatedButton(
              onPressed: () => setState(() {
                    _count += 1;
                  }),
              child: const Text('+1'))
        ],
      ),
    );
  }
}

class MySlideTranstion extends AnimatedWidget {
  const MySlideTranstion(
      {Key? key,
      required Animation<Offset> position,
      this.transformHitTests = true,
      required this.child})
      : super(key: key, listenable: position);

  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<Offset>;
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
