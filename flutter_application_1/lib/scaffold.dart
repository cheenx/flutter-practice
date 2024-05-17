import 'package:flutter/material.dart';

class ScaffoldTestRoute extends StatefulWidget {
  const ScaffoldTestRoute({super.key});

  @override
  State<ScaffoldTestRoute> createState() => _ScaffoldTestState();
}

class _ScaffoldTestState extends State<ScaffoldTestRoute> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Name',
          style: TextStyle(color: Colors.white),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ));
        }),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.blue,
      ),
      drawer: MyDrawer(),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.business), label: 'Business'),
      //     BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
      //   ],
      //   currentIndex: _selectedIndex,
      //   fixedColor: Colors.blue,
      //   onTap: _onItemTapped,
      // ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 60.0,
        shape: CircularNotchedRectangle(), //底部当寒兰打一个圆形的洞
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            SizedBox(),
            IconButton(onPressed: () {}, icon: Icon(Icons.business))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _add() {}
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 38.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: ClipOval(
                        child: Image.asset(
                          'image/avatar.png',
                          width: 60.0,
                        ),
                      ),
                    ),
                    Text(
                      'Wendux',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Add Account'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('manage accounts'),
                  )
                ],
              ))
            ],
          )),
    );
  }
}
