import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsy_github_app/page/home/home_page.dart';
import 'package:gsy_github_app/page/login/login_page.dart';
import 'package:gsy_github_app/page/login/login_webview.dart';
import 'package:gsy_github_app/widget/never_overscroll_indicator.dart';

/// 导航栏
/// Created by guoshuyu
/// Date: 2018-07-16
class NavigatorUtils {
  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
//    if (navigator == null) {
//      try {
//        navigator = Navigator.of(context);
//      } catch (e) {
//        error = true;
//      }
//    }
//
//    if (replace) {
//      ///如果可以返回，清空开始，然后塞入
//      if (!error && navigator.canPop()) {
//        navigator.pushAndRemoveUntil(
//          router,
//          ModalRoute.withName('/'),
//        );
//      } else {
//        ///如果不可返回，直接替换当前
//        navigator.pushReplacement(router);
//      }
//    } else {
//      navigator.push(router);
//    }
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  /// 公共打开方式
  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => pageContainer(widget, context)));
  }

  ///主页
  static goHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  ///登录页
  static goLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

  /// 登录页Web页面
  static Future goLoginWebView(BuildContext context, String url, String title) {
    return NavigatorRouter(context, LoginWebView(url, title));
  }

  /// page页面的容器，做一次通用自定义
  static Widget pageContainer(widget, BuildContext context) {
    return MediaQuery(

        /// 不受系统字体缩放影响
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: NeverOverScrollIndicator(
          needOverload: false,
          child: widget,
        ));
  }

  static Future<T?> showGSYDialog<T>(
      {required BuildContext context,
      bool barrierDismissible = true,
      WidgetBuilder? builder}) {
    return showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
            data: MediaQueryData.fromView(
                    WidgetsBinding.instance.platformDispatcher.views.first)
                .copyWith(textScaler: TextScaler.noScaling),
            child: NeverOverScrollIndicator(
              needOverload: false,
              child: SafeArea(
                child: builder!(context),
              ),
            ),
          );
        });
  }
}
