import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/keep_alive_wrapper.dart';

class TabViewTestRoute extends StatelessWidget {
  const TabViewTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabView Test'),
        backgroundColor: Colors.blue,
      ),
      body: Placeholder(),
    );
  }
}

class TabViewRoute1 extends StatefulWidget {
  const TabViewRoute1({super.key});

  @override
  State<TabViewRoute1> createState() => _TabViewRoute1State();
}

class _TabViewRoute1State extends State<TabViewRoute1>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabs = ['新闻', '历史', '图片'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Name'),
        backgroundColor: Colors.blue,
        bottom: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black54,
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return KeepAliveWrapper(
              child: Container(
            alignment: Alignment.center,
            child: Text(
              e,
              textScaleFactor: 5,
            ),
          ));
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TabViewRoute2 extends StatelessWidget {
  const TabViewRoute2({super.key});

  @override
  Widget build(BuildContext context) {
    List tabs = ['新闻', '历史', '图片'];
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('App Name'),
            backgroundColor: Colors.blue,
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black54,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: tabs
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
            ),
          ),
          body: TabBarView(
              children: tabs.map((e) {
            return KeepAliveWrapper(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                e,
                textScaleFactor: 5,
              ),
            ));
          }).toList()),
        ));
  }
}
