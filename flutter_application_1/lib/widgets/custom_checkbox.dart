import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/widgets/render_onject_animation_mixin.dart';

class CustomCheckBox extends LeafRenderObjectWidget {
  const CustomCheckBox({
    Key? key,
    this.strokeWidth = 2.0,
    this.value = false,
    this.strokeColor = Colors.white,
    this.fillColor = Colors.blue,
    this.radius = 2.0,
    this.onChanged,
  }) : super(key: key);

  final double strokeWidth;
  final Color strokeColor;
  final Color? fillColor;
  final bool value;
  final double radius;
  final ValueChanged<bool>? onChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCheckBox(strokeWidth, strokeColor,
        fillColor ?? Theme.of(context).primaryColor, value, radius, onChanged);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderCustomCheckBox renderObject) {
    if (renderObject.value != value) {
      renderObject.animationStatus =
          value ? AnimationStatus.forward : AnimationStatus.reverse;
    }

    renderObject
      ..strokeWidth = strokeWidth
      ..strokeColor = strokeColor
      ..fillColor = fillColor ?? Theme.of(context).primaryColor
      ..radius = radius
      ..value = value
      ..onChanged = onChanged;
  }
}

class RenderCustomCheckBox extends RenderBox with RenderObjectAnimationMixin {
  bool value;
  int pointerId = -1;
  double strokeWidth;
  Color strokeColor;
  Color fillColor;
  double radius;
  ValueChanged<bool>? onChanged;

  RenderCustomCheckBox(
    this.strokeWidth,
    this.strokeColor,
    this.fillColor,
    this.value,
    this.radius,
    this.onChanged,
  ) {
    progress = value ? 1 : 0;
  }

  @override
  bool get isRepaintBoundary => true;

  //背景动画时长占比（背景动画要在前40%的时间执行完毕，之后执行打勾动画）
  final double bgAnimationInterval = .4;

  @override
  void performLayout() {
    size = constraints
        .constrain(constraints.isTight ? Size.infinite : Size(25.0, 25.0));
  }

  @override
  void doPaint(PaintingContext context, Offset offset) {
    Rect rect = offset & size;
    //将绘制分为背景（矩形）和前景（打勾）两部分，先画背景，再绘制‘√’
    _drawBackground(context, rect);
    _drawCheckMark(context, rect);
  }

  void _drawBackground(PaintingContext context, Rect rect) {
    Color color = value ? fillColor : Colors.grey;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;

    //我们需要算出每一帧里面的矩形的大小，为此我们可以直接根据矩形插值方法来确定里面矩形
    final outer = RRect.fromRectXY(rect, radius, radius);
    var rects = [
      rect.inflate(-strokeWidth),
      Rect.fromCenter(center: rect.center, width: 0, height: 0)
    ];

    // 根据动画执行进度调整来确定里面矩形在每一帧的大小
    var rectProgress = Rect.lerp(
        rects[0],
        rects[1],
        // 背景动画的执行时长是前40%的时间
        min(progress, bgAnimationInterval) / bgAnimationInterval)!;

    final inner = RRect.fromRectXY(rectProgress, 0, 0);
    //绘制
    context.canvas.drawDRRect(outer, inner, paint);
  }

  //画勾
  void _drawCheckMark(PaintingContext context, Rect rect) {
    if (progress > bgAnimationInterval) {
      //确定中间拐点位置
      final secondOffset =
          Offset(rect.left + rect.width / 2.5, rect.bottom - rect.height / 4);
      //第三个点的位置
      final lastOffset =
          Offset(rect.right - rect.width / 6, rect.top + rect.height / 4);

      //我们只对第三个点的位置做插值
      final _lastOffset = Offset.lerp(secondOffset, lastOffset,
          (progress - bgAnimationInterval) / (1 - bgAnimationInterval))!;

      final path = Path()
        ..moveTo(rect.left + rect.width / 7, rect.top + rect.height / 2)
        ..lineTo(secondOffset.dx, secondOffset.dy)
        ..lineTo(_lastOffset.dx, _lastOffset.dy);

      final paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..color = strokeColor
        ..strokeWidth = strokeWidth;

      context.canvas.drawPath(path, paint);
    }
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    if (event.down) {
      pointerId = event.pointer;
    } else if (pointerId == event.pointer) {
      onChanged?.call(!value);
    }
  }
}
