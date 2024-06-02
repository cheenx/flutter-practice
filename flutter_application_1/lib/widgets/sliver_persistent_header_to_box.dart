import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/widgets/sliver_flexible_header.dart';

typedef SliverPersistentHeaderToBoxBuilder = Widget Function(
  BuildContext context,
  double maxExtent,
  bool fixed,
);

class SliverPersistentHeaderToBox extends StatelessWidget {
  SliverPersistentHeaderToBox({Key? key, required Widget child})
      : builder = ((a, b, c) => child),
        super(key: key);

  SliverPersistentHeaderToBox.builder({Key? key, required this.builder})
      : super(key: key);

  final SliverPersistentHeaderToBoxBuilder builder;

  @override
  Widget build(BuildContext context) {
    return _SliverPersistentHeaderToBox(
      child: LayoutBuilder(builder: (context, constraints) {
        return builder(context, constraints.maxHeight,
            (constraints as ExtraInfoBoxConstraints<bool>).extra);
      }),
    );
  }
}

class _SliverPersistentHeaderToBox extends SingleChildRenderObjectWidget {
  const _SliverPersistentHeaderToBox({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSliverPersistentHeaderToBox();
  }
}

class _RenderSliverPersistentHeaderToBox extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }

    child!.layout(
        ExtraInfoBoxConstraints(
            //只要 constraints.scrollOffset不为0，则表示已经有内容在当前sliver下面了，即已经固定到顶部了
            constraints.scrollOffset != 0,
            constraints.asBoxConstraints(
                //我们将剩余的可绘制空间最为header的最大高度约束传递给LayoutBuilder
                maxExtent: constraints.remainingPaintExtent)),
        //我们根据child大小来确定Sliver大小，所以后面需要用到child的大小size信息
        parentUsesSize: true);

    //子节点 layout  后就能获取它的大小了
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }

    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintOrigin: 0,
      paintExtent: childExtent,
      maxPaintExtent: childExtent,
    );
  }

  @override
  double childMainAxisPosition(covariant RenderBox child) => 0.0;
}
