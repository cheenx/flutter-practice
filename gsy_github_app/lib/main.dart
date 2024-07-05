import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app/common/event/http_error_event.dart';
import 'package:gsy_github_app/common/event/index.dart';
import 'package:gsy_github_app/common/localization/default_localizations.dart';
import 'package:gsy_github_app/common/localization/gsy_localizations_delegate.dart';
import 'package:gsy_github_app/common/net/code.dart';
import 'package:gsy_github_app/common/style/gsy_style.dart';
import 'package:gsy_github_app/common/utils/common_utils.dart';
import 'package:gsy_github_app/common/utils/navigator_utils.dart';
import 'package:gsy_github_app/common/utils/toast_utils.dart';
import 'package:gsy_github_app/model/User.dart';
import 'package:gsy_github_app/page/home/home_page.dart';
import 'package:gsy_github_app/page/login/login_page.dart';
import 'package:gsy_github_app/page/welcome_page.dart';
import 'package:gsy_github_app/redux/gsy_state.dart';
import 'package:redux/redux.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(const FlutterReduxApp());
}

class FlutterReduxApp extends StatefulWidget {
  const FlutterReduxApp({super.key});

  @override
  State<FlutterReduxApp> createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp>
    with HttpErrorListener {
  /// 创建Store，引用 GSYState 中的 appReducer 实现Reducer方法
  /// initialState 初始化 State
  final store = Store<GSYState>(appReducer,
      middleware: middlewares,
      initialState: GSYState(
        userInfo: User.empty(),
        login: false,
        themeData: CommonUtils.getThemeDate(GSYColors.primarySwatch),
        locale: const Locale('zh', 'CH'),
      ));

  NavigatorObserver navigatorObserver = NavigatorObserver();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      /// 通过with navigatorObserver，在这里可以获取，可以往上取到
      /// MaterialApp 和 storeProvider 的 context
      /// 还可以获取到navigator
      /// 比如在这里增加一个监听，如果token失效就返回登录页、
      navigatorObserver.navigator!.context;
      navigatorObserver.navigator;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 使用 flutter_redux 做全局状态共享
    /// 通过 StoreProvider 应用store
    return StoreProvider(
        store: store,
        child: StoreBuilder<GSYState>(
          builder: (context, store) {
            /// 使用 StoreBuilder 获取 store 中的theme 、 locale
            store.state.platformLocale =
                WidgetsBinding.instance.platformDispatcher.locale;

            Widget app = MaterialApp(
              navigatorKey: navKey,

              /// 多语言实现代理
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GSYLocalizationsDelegate.delegate
              ],

              supportedLocales: [
                store.state.locale ?? store.state.platformLocale!
              ],
              locale: store.state.locale,
              theme: store.state.themeData,
              navigatorObservers: [navigatorObserver],

              routes: {
                WelcomePage.sName: (context) {
                  return const WelcomePage();
                },
                HomePage.sName: (context) {
                  return NavigatorUtils.pageContainer(
                      const HomePage(), context);
                },
                LoginPage.sName: (context) {
                  return NavigatorUtils.pageContainer(
                      const LoginPage(), context);
                },
              },
            );

            if (store.state.grey) {
              /// mode one
              app = ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Colors.grey, BlendMode.saturation),
                child: app,
              );

              /// mode two
              /// app = ColorFiltered(
              ///     colorFilter:greyscale,
              ///     child:app);
            }

            return app;
          },
        ));
  }
}

mixin HttpErrorListener on State<FlutterReduxApp> {
  StreamSubscription? stream;

  GlobalKey<NavigatorState> navKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream?.cancel();
      stream = null;
    }
  }

  errorHandleFunction(int? code, message) {
    var context = navKey.currentContext!;
    switch (code) {
      case Code.NETWORK_ERROR:
        showToast(GSYLocalizations.i18n(context)!.network_error);
        break;
      case 401:
        showToast(GSYLocalizations.i18n(context)!.network_error_401);
        break;
      case 403:
        showToast(GSYLocalizations.i18n(context)!.network_error_403);
        break;
      case 404:
        showToast(GSYLocalizations.i18n(context)!.network_error_404);
        break;
      case 422:
        showToast(GSYLocalizations.i18n(context)!.network_error_422);
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        showToast(GSYLocalizations.i18n(context)!.network_error_timeout);
        break;
      case Code.GITHUB_API_REFUSED:
        //Github API 异常
        showToast(GSYLocalizations.i18n(context)!.github_refused);
        break;
      default:
        showToast(
            "${GSYLocalizations.i18n(context)!.network_error_unknown} $message");
        break;
    }
  }

  showToast(String message) {
    ToastUtils.showToast(msg: message);
  }
}
