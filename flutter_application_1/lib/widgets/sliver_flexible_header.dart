import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef SliverFlexibleHeaderBuilder = Widget Function(
    BuildContext context, double maxExtent, ScrollDirection direction);

class SliverFlexibleHeader extends StatelessWidget {
  const SliverFlexibleHeader(
      {super.key, this.visibleExtent = 0, required this.builder});

  final SliverFlexibleHeaderBuilder builder;
  final double visibleExtent;

  @override
  Widget build(BuildContext context) {
    return _SliverFlexibleHeader(
        visibleExtent: visibleExtent,
        child: LayoutBuilder(builder: ((context, constraints) {
          print('constraints maxHeight = ${constraints.maxHeight}');
          return builder(
              context,
              constraints.maxHeight,
              //获取滑动方向
              (constraints as ExtraInfoBoxConstraints<ScrollDirection>).extra);
        })));
  }
}

class ExtraInfoBoxConstraints<T> extends BoxConstraints {
  ExtraInfoBoxConstraints(this.extra, BoxConstraints constraints)
      : super(
          minWidth: constraints.minWidth,
          minHeight: constraints.minHeight,
          maxWidth: constraints.maxWidth,
          maxHeight: constraints.maxHeight,
        );
  //额外的信息
  final T extra;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExtraInfoBoxConstraints &&
        super == other &&
        other.extra == extra;
  }

  @override
  int get hashCode {
    return hashValues(super.hashCode, extra);
  }
}

class _SliverFlexibleHeader extends SingleChildRenderObjectWidget {
  const _SliverFlexibleHeader(
      {Key? key, required Widget child, this.visibleExtent = 0.0})
      : super(key: key, child: child);

  final double visibleExtent;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _FlexibleHeaderRenderSliver(visibleExtent);
  }

  @override
  void updateRenderObject(
      BuildContext context, _FlexibleHeaderRenderSliver renderObject) {
    renderObject.visivbleExtent = visibleExtent;
  }
}

class _FlexibleHeaderRenderSliver extends RenderSliverSingleBoxAdapter {
  _FlexibleHeaderRenderSliver(double visibleExtent)
      : _visibleExtent = visibleExtent;

  double _lastOverScroll = 0;
  double _lastScrollOffset = 0;
  late double _visibleExtent = 0;
  var _direction = ScrollDirection.idle;
  //是否需要修正scrollOffset。当_visivleExtent值更新后，为了防止
  //视觉上突然地跳动，要先修正 scrollOffset。
  double? _scrollOffsetCorrection;
  // 该变量用来确保Sliver完全离开屏幕时会通知child且只通知一次.
  bool _reported = false;

  set visivbleExtent(double value) {
    //可视长度发生变化，更新状态并重新布局
    if (_visibleExtent != value) {
      _lastOverScroll = 0;
      _visibleExtent = value;
      //计算修正值
      _scrollOffsetCorrection = value - _visibleExtent;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    // _visibleExtent 值更新后，为了防止突然的跳动， 先修正 scrollOffset
    if (_scrollOffsetCorrection != null) {
      geometry = SliverGeometry(
        scrollOffsetCorrection: _scrollOffsetCorrection,
      );
      _scrollOffsetCorrection = null;
      return;
    }

    //滑动距离大于_visibleExtent时则表示子节点已经在屏幕之外了
    if (child == null) {
      geometry = SliverGeometry(scrollExtent: _visibleExtent);
      return;
    }

    //当已经完全滑出屏幕时
    if (constraints.scrollOffset > _visibleExtent) {
      geometry = SliverGeometry(scrollExtent: _visibleExtent);

      if (!_reported) {
        _reported = true;
        child?.layout(
            ExtraInfoBoxConstraints(
                _direction, constraints.asBoxConstraints(maxExtent: 0)),
            parentUsesSize: false);
      }
      return;
    }

    _reported = false;

    //测试overlap，下拉过程中overlap会一直变化
    double overScroll = constraints.overlap < 0 ? constraints.overlap.abs() : 0;
    var scrollOffset = constraints.scrollOffset;
    _direction = ScrollDirection.idle;

    //根据前后的overScroll值之差确定列表滑动方向。注意，不能直接使用constraints.useScrollDirection,
    // 这是因为该参数只表示用户滑动操作的方向。比如当我们下拉超过边界时。然后松手，此时列表会弹回，即列表滚动方向是向上，
    // 而此时用户操作已经结束，ScrollDirection 的方向是上一次的用户滑动方向（向下）这便是问题。
    var distance = overScroll > 0
        ? overScroll - _lastOverScroll
        : _lastScrollOffset - scrollOffset;

    _lastOverScroll = overScroll;
    _lastScrollOffset = scrollOffset;

    print('distance = $distance');

    if (constraints.userScrollDirection == ScrollDirection.idle) {
      _direction = ScrollDirection.idle;
      _lastOverScroll = 0;
    } else if (distance > 0) {
      _direction = ScrollDirection.forward;
    } else if (distance < 0) {
      _direction = ScrollDirection.reverse;
    }

    //在Viewport中顶部的可视空间为该 Sliver 可绘制的最大区域
    // 1. 如果Sliver已经滑出可视区域则 constrains.scrollOffset 会大于 _visibleExtent
    //    这种情况我们一开始就判断过了
    // 2. 如果我们下拉超出了边界，此时overlap > 0, scrollOffset 值为0，所以最终的绘制区域为
    //    _visibleExtent + overScroll
    double paintExtent = _visibleExtent + overScroll - constraints.scrollOffset;
    // 绘制高度不超过最大可绘制空间
    paintExtent = min(paintExtent, constraints.remainingPaintExtent);

    //子组件通过layoutBuilder可以拿到这里我们传递的约束对象(ExtraInfoBoxConstraints)
    child!.layout(
        ExtraInfoBoxConstraints(
            _direction, constraints.asBoxConstraints(maxExtent: paintExtent)),
        parentUsesSize: false);

    //最大为_visibleExtent， 最小为0
    double layoutExtent = min(_visibleExtent, paintExtent);

    //设置geometry，Viewport 在布局时会用到
    geometry = SliverGeometry(
        scrollExtent: layoutExtent,
        paintOrigin: -overScroll,
        paintExtent: paintExtent,
        maxPaintExtent: paintExtent,
        layoutExtent: layoutExtent);
  }
}
