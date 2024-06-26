import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:gsy_github_app/common/style/gsy_style.dart';
import 'package:gsy_github_app/widget/gsy_tabbar_widget.dart';

class HomePage extends StatefulWidget {
  static const String sName = "home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> tabs = [
    SizedBox(height: 49.0, child: Icon(Icons.home)),
    SizedBox(height: 49.0, child: Icon(Icons.question_answer)),
    SizedBox(height: 49.0, child: Icon(Icons.person))
  ];
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          _dialogExitApp(context);
        },
        child: GSYTabBarWidget(
          type: TabType.bottom,
          tabItems: tabs,
          tabViews: [
            Container(color: Colors.red),
            Container(color: Colors.grey),
            Container(color: Colors.blue),
          ],
          backgroundColor: GSYColors.primarySwatch,
          indicatorColor: GSYColors.white,
        ));
  }

  /// 不退出
  _dialogExitApp(BuildContext context) async {
    ///如果是Android 回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = const AndroidIntent(
        action: "android.intent.action.MAIN",
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
  }
}
