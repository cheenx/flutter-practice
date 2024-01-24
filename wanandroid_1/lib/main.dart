import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wanandroid_1/pages/mine.dart';
import 'package:wanandroid_1/pages/blog.dart';
import 'package:wanandroid_1/pages/project.dart';
import 'package:wanandroid_1/pages/system.dart';
import 'package:wanandroid_1/pages/mine.dart';
import 'package:wanandroid_1/pages/weixin_blog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wan Android',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> contentPages = [
    BlogPage(),
    ProjectPage(),
    WeixinPage(),
    SystemPage(),
    MinePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void getProjectCategories() async {
    Response response =
        await get(Uri.parse('https://www.wanandroid.com/project/tree/json'));
    Map<String, dynamic> body = JsonDecoder().convert(response.body);
    List<dynamic> data = body['data'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getProjectCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contentPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0),
        backgroundColor: Colors.grey[200],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '博文',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.propane),
            label: '项目',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '公众号',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online_sharp),
            label: '体系',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
