import 'package:flutter/material.dart';

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrikOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  //child为header
  SliverHeaderDelegate(
      {required this.maxHeight, this.minHeight = 0, required Widget child})
      : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  SliverHeaderDelegate.fixedHeight(
      {required double height, required Widget child})
      : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  SliverHeaderDelegate.builder(
      {required this.maxHeight, this.minHeight = 0, required this.builder});

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    assert(() {
      // 测试代码： 如果在调试模式，且子组件设置了key，则打印日志
      if (child.key != null) {
        print(
            '${child.key}:  shrink: $shrinkOffset, overlaps: $overlapsContent');
      }
      return true;
    }());
    // 让 header 尽可能充满限制空间；宽度为 Viewport 宽度，
    // 高度随着用户滑动在[minHeight,maxHeight]之间变化
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent &&
        oldDelegate.minExtent != minExtent;
  }
}
