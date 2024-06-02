import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/sliver_persistent_header.dart';
import 'package:flutter_application_1/widgets/sliver_flexible_header.dart';
import 'package:flutter_application_1/widgets/sliver_persistent_header_to_box.dart';

class CustomSliverTestRoute extends StatelessWidget {
  const CustomSliverTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliveFlexibleHeader'),
        backgroundColor: Colors.blue,
      ),
      body: SliverPersistentHeaderToBoxRoute(),
    );
  }
}

class SliverPersistentHeaderToBoxRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildSliverList(5),
        SliverPersistentHeaderToBox.builder(builder: headerBuilder),
        buildSliverList(5),
        SliverPersistentHeaderToBox(child: wTitle('Title 2')),
        buildSliverList(50)
      ],
    );
  }
}

Widget headerBuilder(context, maxExtent, fixed) {
  var theme = Theme.of(context);
  return Material(
    child: Container(
      color: fixed ? Colors.white : theme.canvasColor,
      child: wTitle('Title 1'),
    ),
    elevation: fixed ? 4 : 0,
    shadowColor: theme.appBarTheme.shadowColor,
  );
}

Widget wTitle(String text) => ListTile(
      title: Text(text),
      onTap: () => print(text),
    );

class CustomSliver1 extends StatelessWidget {
  const CustomSliver1({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //位了能够CustomScrollView拉倒顶部时还能继续往下拉，必须让 physics 支持弹性效果
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        //我们需要实现的 SliverFlexibleHeader 组件
        SliverFlexibleHeader(
          visibleExtent: 200, //初始装填在列表占用的布局高度
          builder: (context, availableHeight, direction) {
            return GestureDetector(
              onTap: () {
                print('tap');
              },
              child: Image(
                image: const AssetImage('image/avatar.png'),
                width: 50.0,
                height: availableHeight,
                alignment: Alignment.bottomCenter,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        SliverFixedExtentList.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('$index'),
              );
            },
            itemExtent: 50)
      ],
    );
  }
}
