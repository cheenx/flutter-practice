import 'package:flutter/material.dart';

class CustomScrollTestRoute extends StatelessWidget {
  const CustomScrollTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: Text('Custom Scroll Test')),
    //   body: CustomScrollTest2(),
    // );
    return CustomScrollTest2();
  }
}

class CustomScrollTest1 extends StatelessWidget {
  const CustomScrollTest1({super.key});

  @override
  Widget build(BuildContext context) {
    return buildTwoListView();
  }
}

Widget buildTwoListView() {
  // var listView = ListView.builder(
  //     itemCount: 20,
  //     itemBuilder: (_, index) {
  //       return ListTile(
  //         title: Text('$index'),
  //       );
  //     });

  // return Column(
  //   children: [
  //     Expanded(child: listView),
  //     const Divider(color: Colors.grey),
  //     Expanded(child: listView)
  //   ],
  // );

  var listView = SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(
                title: Text('$index'),
              ),
          childCount: 20),
      itemExtent: 56);

  return CustomScrollView(
    slivers: [listView, listView],
  );
}

class CustomScrollTest2 extends StatelessWidget {
  const CustomScrollTest2({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          //AppBar 包含一个导航栏
          SliverAppBar(
            //滑动到顶部时会固定住
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Demo'),
              background: Image.asset(
                'image/sea.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300.0,
              child: PageView(
                children: [
                  Center(
                      child: Text(
                    '1',
                    textScaler: TextScaler.linear(5.0),
                  )),
                  Center(
                      child: Text(
                    '2',
                    textScaler: TextScaler.linear(5.0),
                  )),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                }, childCount: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 4.0)),
          ),
          SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('list item $index'),
                );
              }, childCount: 20),
              itemExtent: 50.0)
        ],
      ),
    );
  }
}
