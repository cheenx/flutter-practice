import 'package:flutter/material.dart';

class WillPopScopeTestRoute extends StatefulWidget {
  const WillPopScopeTestRoute({super.key});

  @override
  State<WillPopScopeTestRoute> createState() => _WillPopScopeTestRouteState();
}

class _WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime? _lastPressAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Container(
          alignment: Alignment.center,
          child: Text('1秒内连续两次返回键退出'),
        ),
        onWillPop: () async {
          if (_lastPressAt == null ||
              DateTime.now().difference(_lastPressAt!) > Duration(seconds: 1)) {
            _lastPressAt = DateTime.now();
            return false;
          }
          return true;
        });
    // return PopScope(
    //   child: Container(
    //     alignment: Alignment.center,
    //     child: Text('1秒内连续两次返回键退出'),
    //   ),
    //   canPop: false,

    // );
  }
}
