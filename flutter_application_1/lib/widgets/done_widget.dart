import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/render_onject_animation_mixin.dart';

class DoneWidget extends LeafRenderObjectWidget {
  const DoneWidget({
    Key? key,
    this.strokeWidth = 2.0,
    this.color = Colors.green,
    this.outline = false,
  }) : super(key: key);

  //线条宽度
  final double strokeWidth;
  // 轮廓颜色或填充色
  final Color color;
  // 如果为true，则没有填充色，color代表为轮廓颜色；如果为false，则color为填充色
  final bool outline;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderDoneObject(
      strokeWidth,
      color,
      outline,
    )..animationStatus = AnimationStatus.forward;
  }

  @override
  void updateRenderObject(BuildContext context, RenderDoneObject renderObject) {
    renderObject
      ..strokeWidth = strokeWidth
      ..outline = outline
      ..color = color;
  }
}

class RenderDoneObject extends RenderBox with RenderObjectAnimationMixin {
  double strokeWidth;
  Color color;
  bool outline;
  int pointerId = -1;

  ValueChanged<bool>? onChanged;

  RenderDoneObject(this.strokeWidth, this.color, this.outline);

  @override
  Duration get duration => const Duration(milliseconds: 500);

  @override
  void doPaint(PaintingContext context, Offset offset) {
    //可以对动画运用曲线
    Curve curve = Curves.easeIn;
    final _progress = curve.transform(progress);

    Rect rect = offset & size;
    final paint = Paint()
      ..isAntiAlias = true
      ..style = outline ? PaintingStyle.stroke : PaintingStyle.fill
      ..color = color;

    if (outline) {
      paint.strokeWidth = strokeWidth;
      rect = rect.deflate(strokeWidth / 2);
    }

    //画背景图
    context.canvas.drawCircle(rect.center, rect.shortestSide / 2, paint);

    paint
      ..style = PaintingStyle.stroke
      ..color = outline ? color : Colors.white
      ..strokeWidth = strokeWidth;

    final path = Path();

    Offset firstOffset =
        Offset(rect.left + rect.width / 6, rect.top + rect.height / 2.1);

    final secondOffset =
        Offset(rect.left + rect.width / 2.5, rect.bottom - rect.height / 3.3);

    path.moveTo(firstOffset.dx, firstOffset.dy);

    const adjustProgress = .6;

    //画勾
    if (_progress < adjustProgress) {
      //第一个点到第二个点的连线做动画（第二个点不停地变）
      Offset _secondOffset =
          Offset.lerp(firstOffset, secondOffset, _progress / adjustProgress)!;

      path.lineTo(_secondOffset.dx, _secondOffset.dy);
    } else {
      path.lineTo(secondOffset.dx, secondOffset.dy);
      final lastOffset =
          Offset(rect.right - rect.width / 5, rect.top + rect.height / 3.5);
      Offset _lastOffset = Offset.lerp(secondOffset, lastOffset,
          (progress - adjustProgress) / (1 - adjustProgress))!;

      path.lineTo(_lastOffset.dx, _lastOffset.dy);
    }

    context.canvas.drawPath(path, paint..style = PaintingStyle.stroke);
  }

  @override
  void performLayout() {
    size = constraints.constrain(
        constraints.isTight ? Size.infinite : const Size(25.0, 25.0));
  }

  @override
  bool hitTestSelf(Offset position) => true;

  // @override
  // void handleEvent(
  //     PointerEvent event, covariant HitTestEntry<HitTestTarget> entry) {
  //   if (event.down) {
  //     pointerId = event.pointer;
  //   } else if (pointerId == event.pointer) {
  //     onChanged?.call(!value);
  //   }
  // }
}
