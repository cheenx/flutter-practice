import 'package:flutter/material.dart';
import 'package:gsy_github_app/common/utils/navigator_utils.dart';
import 'package:gsy_github_app/page/home/home_page.dart';
import 'package:gsy_github_app/page/login/login_page.dart';
import 'package:gsy_github_app/page/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        WelcomePage.sName: (context) {
          return const WelcomePage();
        },
        LoginPage.sName: (context) {
          return NavigatorUtils.pageContainer(const LoginPage(), context);
        },
        HomePage.sName: (context) {
          return NavigatorUtils.pageContainer(const HomePage(), context);
        }
      },
    );
  }
}
