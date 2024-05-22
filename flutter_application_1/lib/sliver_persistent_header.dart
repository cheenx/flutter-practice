import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/sliver_header_delegate.dart';

class SliverPersistentHeaderTestRoute extends StatelessWidget {
  const SliverPersistentHeaderTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverPersistentHeader Test'),
      ),
      body: PersistentHeaderRoute(),
    );
  }
}

class PersistentHeaderRoute extends StatelessWidget {
  const PersistentHeaderRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildSliverList(),
        SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(
                maxHeight: 80.0, minHeight: 50.0, child: buildHeader(1))),
        buildSliverList(),
        SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate.fixedHeight(
                height: 50.0, child: buildHeader(2))),
        buildSliverList(20),
      ],
    );
  }
}

Widget buildHeader(int i) {
  return Container(
    key: Key('build_header_$i'),
    color: Colors.lightBlue.shade200,
    alignment: Alignment.centerLeft,
    child: Text('PersistentHeader $i'),
  );
}

Widget buildSliverList([int count = 5]) {
  return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return ListTile(
          title: Text('$index'),
        );
      }, childCount: count),
      itemExtent: 50);
}
