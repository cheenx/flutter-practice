import 'package:flutter/material.dart';
import 'package:flutter_application_1/sliver_persistent_header.dart';

class NestedScrollViewTestRoute extends StatelessWidget {
  const NestedScrollViewTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedTabBarView1();
  }
}

class NestedScrollViewTest1 extends StatelessWidget {
  const NestedScrollViewTest1({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
          headerSliverBuilder: ((context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text("嵌套ListView"),
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                backgroundColor: Colors.blue,
              ),
              buildSliverList(5)
            ];
          }),
          body: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              physics: const ClampingScrollPhysics(),
              itemCount: 30,
              itemBuilder: ((context, index) {
                return SizedBox(
                  height: 50.0,
                  child: Center(
                    child: Text('Item $index'),
                  ),
                );
              }))),
    );
  }
}

class SnapAppBar extends StatelessWidget {
  const SnapAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                floating: true,
                snap: true,
                expandedHeight: 200.0,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'image/sea.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ];
        },
        body: Builder(builder: (context) {
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              buildSliverList(100)
            ],
          );
        }),
      ),
    );
  }
}

class SnapAppBar2 extends StatefulWidget {
  const SnapAppBar2({super.key});

  @override
  State<SnapAppBar2> createState() => _SnapAppBar2State();
}

class _SnapAppBar2State extends State<SnapAppBar2> {
  late SliverOverlapAbsorberHandle handle;

  void onOverlapChanged() {
    print('handle.layoutExtent = ${handle.layoutExtent}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          NestedScrollView(headerSliverBuilder: ((context, innerBoxIsScrolled) {
        handle = NestedScrollView.sliverOverlapAbsorberHandleFor(context);
        //添加监听前先移除旧的
        handle.removeListener(() {
          onOverlapChanged();
        });
        //overlap长度发生变化时打印
        handle.addListener(() {
          onOverlapChanged();
        });
        return <Widget>[
          SliverOverlapAbsorber(
            handle: handle,
            sliver: SliverAppBar(
              floating: true,
              snap: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'image/sea.png',
                  fit: BoxFit.cover,
                ),
              ),
              forceElevated: innerBoxIsScrolled,
            ),
          )
        ];
      }), body: LayoutBuilder(builder: ((context, constraints) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(handle: handle),
            buildSliverList(100)
          ],
        );
      }))),
    );
  }

  @override
  void dispose() {
    handle.removeListener(onOverlapChanged);
    super.dispose();
  }
}

class NestedTabBarView1 extends StatelessWidget {
  const NestedTabBarView1({super.key});

  @override
  Widget build(BuildContext context) {
    final _tabs = <String>['猜你喜欢', '今日特价', '发现更多'];

    return DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: ((context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      title: const Text('商城'),
                      floating: true,
                      snap: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                          tabs: _tabs
                              .map((String name) => Tab(
                                    text: name,
                                  ))
                              .toList()),
                    ),
                  )
                ];
              }),
              body: TabBarView(
                  children: _tabs.map((String name) {
                return Builder(builder: (context) {
                  return CustomScrollView(
                    key: PageStorageKey<String>(name),
                    slivers: [
                      SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context)),
                      SliverPadding(
                        padding: EdgeInsets.all(8.0),
                        sliver: buildSliverList(50),
                      )
                    ],
                  );
                });
              }).toList())),
        ));
  }
}
