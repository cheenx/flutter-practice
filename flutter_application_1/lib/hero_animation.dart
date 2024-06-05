import 'package:flutter/material.dart';
import 'package:flutter_application_1/point_listener.dart';
import 'package:flutter_application_1/widgets/after_layout.dart';

class HeroTestRoute extends StatelessWidget {
  const HeroTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Test'),
      ),
      body: HeroAnimationRouteA(),
    );
  }
}

class CustomHeroAnimation extends StatefulWidget {
  const CustomHeroAnimation({super.key});

  @override
  State<CustomHeroAnimation> createState() => _CustomHeroAnimationState();
}

class _CustomHeroAnimationState extends State<CustomHeroAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _animating = false;
  AnimationStatus? _lastAnimationStatus;
  late Animation _animation;

  Rect? child1Rect;
  Rect? child2Rect;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.addListener(() {
      if (_controller.isCompleted || _controller.isDismissed) {
        if (_animating) {
          setState(() {
            _animating = false;
          });
        }
      } else {
        _lastAnimationStatus = _controller.status;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget child1 = wChild1();
    final Widget child2 = wChild2();

    bool showChild1 =
        !_animating && _lastAnimationStatus != AnimationStatus.forward;

    Widget targetWidget;
    if (showChild1 || _controller.status == AnimationStatus.reverse) {
      targetWidget = child1;
    } else {
      targetWidget = child2;
    }
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            if (showChild1)
              AfterLayout(
                callback: (value) => child1Rect = _getRect(value),
                child: child1,
              ),
            if (!showChild1)
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final rect =
                      Rect.lerp(child1Rect, child2Rect, _animation.value);
                  return Positioned.fromRect(rect: rect!, child: child!);
                },
                child: targetWidget,
              ),
            IgnorePointer(
              child: Center(
                child: Opacity(
                  opacity: 0,
                  child: AfterLayout(
                    callback: (value) => child2Rect = _getRect(value),
                    child: child2,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget wChild1() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _animating = true;
          _controller.forward();
        });
      },
      child: SizedBox(
        width: 50.0,
        child: ClipOval(child: Image.asset('image/avatar.png')),
      ),
    );
  }

  Widget wChild2() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _animating = true;
          _controller.reverse();
        });
      },
      child: Image.asset(
        'image/avatar.png',
        width: 200,
      ),
    );
  }

  Rect _getRect(RenderAfterLayout renderAfterLayout) {
    return renderAfterLayout.localToGlobal(
          Offset.zero,
          ancestor: context.findRenderObject(),
        ) &
        renderAfterLayout.size;
  }
}

class HeroAnimationRouteA extends StatelessWidget {
  const HeroAnimationRouteA({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          InkWell(
            child: Hero(
              tag: 'avatar',
              child: ClipOval(
                child: Image.asset(
                  'image/avatar.png',
                  width: 50.0,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: Scaffold(
                    appBar: AppBar(title: Text('原图')),
                    body: const HeroAnimationRouteB(),
                  ),
                );
              }));
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text('点击头像'),
          )
        ],
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  const HeroAnimationRouteB({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
          tag: 'avatar',
          child: Image.asset(
            'image/avatar.png',
            width: 300.0,
          )),
    );
  }
}
