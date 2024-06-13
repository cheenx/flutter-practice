import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/alert_dialog.dart';
import 'package:flutter_application_1/animated_list.dart';
import 'package:flutter_application_1/animation_controller.dart';
import 'package:flutter_application_1/animation_switcher.dart';
import 'package:flutter_application_1/animation_test.dart';
import 'package:flutter_application_1/asset_manager.dart';
import 'package:flutter_application_1/child_layout.dart';
import 'package:flutter_application_1/clip.dart';
import 'package:flutter_application_1/container.dart';
import 'package:flutter_application_1/custom_backgammon.dart';
import 'package:flutter_application_1/custom_check_box.dart';
import 'package:flutter_application_1/custom_scroll.dart';
import 'package:flutter_application_1/custom_sliver.dart';
import 'package:flutter_application_1/decorated_box.dart';
import 'package:flutter_application_1/dio_test.dart';
import 'package:flutter_application_1/file_operation.dart';
import 'package:flutter_application_1/fitted_box.dart';
import 'package:flutter_application_1/flex_layout.dart';
import 'package:flutter_application_1/flow_layout.dart';
import 'package:flutter_application_1/gesture_conflict.dart';
import 'package:flutter_application_1/gesture_detector.dart';
import 'package:flutter_application_1/custom_widget.dart';
import 'package:flutter_application_1/grid_view.dart';
import 'package:flutter_application_1/hero_animation.dart';
import 'package:flutter_application_1/http_test.dart';
import 'package:flutter_application_1/inherited.dart';
import 'package:flutter_application_1/json_convert.dart';
import 'package:flutter_application_1/l10n/localization_intl.dart';
import 'package:flutter_application_1/layout_builder.dart';
import 'package:flutter_application_1/linear_layout.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/nested_scroll.dart';
import 'package:flutter_application_1/notification.dart';
import 'package:flutter_application_1/pack_manager.dart';
import 'package:flutter_application_1/page_view.dart';
import 'package:flutter_application_1/point_listener.dart';
import 'package:flutter_application_1/provider_test.dart';
import 'package:flutter_application_1/route_manger.dart';
import 'package:flutter_application_1/scaffold.dart';
import 'package:flutter_application_1/scroll_controller.dart';
import 'package:flutter_application_1/scroll_listener.dart';
import 'package:flutter_application_1/sliver.dart';
import 'package:flutter_application_1/sliver_persistent_header.dart';
import 'package:flutter_application_1/socket_test.dart';
import 'package:flutter_application_1/stack_layout.dart';
import 'package:flutter_application_1/stagger_animation.dart';
import 'package:flutter_application_1/state_manager.dart';
import 'package:flutter_application_1/sync_ui.dart';
import 'package:flutter_application_1/tab.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:flutter_application_1/transform.dart';
import 'package:flutter_application_1/value_listen.dart';
import 'package:flutter_application_1/web_socket.dart';
import 'package:flutter_application_1/will_pop.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DemoLocalizationsDelegate()
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 美国英语
        const Locale('zh', 'CN') //中文简体
      ],
      onGenerateTitle: (context) {
        return DemoLocalizations.of(context)?.title ?? 'Flutter APP';
      },
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (context) {
      //     String routeName = settings.name ?? '';
      //     switch (routeName) {
      //       case 'new_page':
      //         return EchoRoute();
      //       case 'router_test':
      //         return RouterTestRoute();
      //       default:
      //         return MyHomePage(title: 'Flutter Demo Home Page');
      //     }
      //   });
      // },
      routes: {
        'new_page': (context) => EchoRoute(),
        'router_test': (context) => RouterTestRoute(),
        'tip2': (context) {
          return TipRoute(
              text: '${ModalRoute.of(context)?.settings.arguments}');
        },
        'random_words': (context) => RandomWordsWidget(),
        'assets_test': (context) => AssetsTestRoute(),
        'login_page': (context) => LoginPageWidget(),
        'layout_test': (context) => ConstrainedBoxTestRoute(),
        'linear_layout': (context) => LinearLayoutTestRoute(),
        'flex_layout': (context) => FlexLayoutTestRoute(),
        'flow_layout': (context) => FlowLayoutTestRoute(),
        'stack_layout': (context) => StackLayoutTestRoute(),
        'layout_builder': (context) => LayoutBuilderTestRoute(),
        'decorated_box': (context) => DecortatedBoxTest(),
        'transform_test': (context) => TransFormTestRoute(),
        'container_test': (context) => ContainerTestRoute(),
        'clip_test': (context) => ClipTestRoute(),
        'fitted_test': (context) => FittedBoxTestRoute(),
        'scaffold_test': (context) => ScaffoldTestRoute(),
        'sliver_test': (context) => CliverTestRoute(),
        'scroll_controller_test': (context) => ScrollControllerTestRoute(),
        'scroll_listener_test': (context) => ScrollNotificationTestRoute(),
        'animated_list_test': (context) => AnimatedListTestRoute(),
        'grid_view_test': (context) => GridViewTestRoute(),
        'page_view_test': (context) => PageViewTestRoute(),
        'tab_view_test': (context) => TabViewRoute2(),
        'custom_scroll_test': (context) => CustomScrollTestRoute(),
        'custom_sliver_test': (context) => CustomSliverTestRoute(),
        'nested_scroll_test': (context) => NestedScrollViewTestRoute(),
        'will_pop_test': (context) => WillPopScopeTestRoute(),
        'inherited_test': (context) => InheritedWidgetTestRoute(),
        'provider_test': (context) => ProviderTestRoute(),
        'theme_test': (context) => ThemeTestRoute1(),
        'value_listen_test': (context) => ValueListenableRoute(),
        'sync_ui_test': (context) => SyncUiTestRoute(),
        'alert_dialog_test': (context) => AlertDialogTestRoute(),
        'point_listener_test': (context) => PointListenerTestRoute(),
        'gesture_detector_test': (context) => GestureDetectorTestRoute(),
        'gesture_conflict_test': (context) => GestureConflictTestRoute(),
        'notify_test': (context) => NotifyTestRoute(),
        'animation_test': (context) => AnimationTestRoute(),
        'hero_test': (context) => HeroTestRoute(),
        'stagger_animation_test': (context) => StaggerAnimationTestRoute(),
        'animated_switcher_test': (context) => AnimatedSwitcherTestRoute(),
        'animated_controller_test': (context) => AnimationControllerTestRoute(),
        'custom_widget_test': (context) => CustomeWidgetTestRoute(),
        'custom_backgammon_test': (context) => CustomBackgammonTestRoute(),
        'custom_checkbox_test': (context) => CustomCheckBoxTestRoute(),
        'file_operation_test': (context) => FileOperationRoute(),
        'http_test': (context) => HttpTestRoute(),
        'dio_test': (context) => DioTestRoute(),
        'web_socket_test': (context) => WebSocketRoute(),
        'socket_test': (context) => SocketTestRoute(),
        'json_convert_test': (context) => JsonConvertTestRoute(),
        'persistent_header_test': (context) =>
            SliverPersistentHeaderTestRoute(),
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page') //注册首页路由
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _lastPressedAt;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(DemoLocalizations.of(context)?.title ?? 'title'),
          ),
          body: Center(
            // child: Echo(text: 'hello world'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     PageRouteBuilder(
                      //         transitionDuration: Duration(milliseconds: 1000),
                      //         pageBuilder:
                      //             ((context, animation, secondaryAnimation) {
                      //           return FadeTransition(
                      //             opacity: animation,
                      //             child: AnimationTestRoute(),
                      //           );
                      //         })));
                      // Navigator.push(context, FadeRoute(builder: (context) {
                      //   return AnimationTestRoute();
                      // }));
                      // Navigator.pushNamed(context, 'new_page');
                      Navigator.of(context).pushNamed('json_convert_test');
                    },
                    child: Text('open new route'))
              ],
            ),
          ),
        ),
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt!) >
                  const Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressedAt = DateTime.now();
            print('1秒内连续两次退出');
            return false;
          }
          return true;
        });
  }
}

class Echo extends StatelessWidget {
  const Echo({Key? key, required this.text, this.backgroundColor = Colors.grey})
      : super(key: key);

  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}

class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Context测试')),
      body: Container(
        child: Builder(builder: (context) {
          Scaffold? scaffold =
              context.findAncestorWidgetOfExactType<Scaffold>();
          return (scaffold?.appBar as AppBar).title ?? Text('Context 测试');
        }),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key, this.initValue = 0}) : super(key: key);

  final int initValue;

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = widget.initValue;
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('$_counter'),
          onPressed: () => setState(() {
            ++_counter;
          }),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}

class StateLifecycleTest extends StatelessWidget {
  const StateLifecycleTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetStateObjectRoute();
  }
}

class GetStateObjectRoute extends StatefulWidget {
  const GetStateObjectRoute({Key? key}) : super(key: key);

  @override
  _GetStateObjectRouteState createState() => _GetStateObjectRouteState();
}

class _GetStateObjectRouteState extends State<GetStateObjectRoute> {
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('子树中获取State对象'),
      ),
      body: Center(
        child: Column(
          children: [
            Builder(
              builder: ((context) {
                return ElevatedButton(
                    onPressed: () {
                      ScaffoldState? _state =
                          context.findAncestorStateOfType<ScaffoldState>();
                      _state?.openDrawer();
                    },
                    child: Text('打开抽屉菜单1'));
              }),
            ),
            Builder(
              builder: ((context) {
                return ElevatedButton(
                    onPressed: () {
                      ScaffoldState _state = Scaffold.of(context);
                      _state.openDrawer();
                    },
                    child: Text('打开抽屉菜单2'));
              }),
            ),
            Builder(builder: (context) {
              return ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('我是SnackBar')),
                    );
                  },
                  child: Text('显示SnackBar'));
            }),
            Builder(
              builder: ((context) {
                return ElevatedButton(
                    onPressed: () {
                      _globalKey.currentState?.openDrawer();
                    },
                    child: Text('打开抽屉菜单4'));
              }),
            ),
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}

class CustomWidget extends LeafRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    //创建 RenderObject
    return RenderCustomObject();
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    //更新 RenderObject
    super.updateRenderObject(context, renderObject);
  }
}

class RenderCustomObject extends RenderBox {
  @override
  void performLayout() {
    super.performLayout();
    //实现布局逻辑
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    //实现绘制
  }
}

class CupertinoTestRoute extends StatelessWidget {
  const CupertinoTestRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Cupertino Demo'),
        ),
        child: Center(
          child: CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: Text('Press'),
              onPressed: () {}),
        ));
  }
}

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
  }
}

class FadeRoute extends PageRoute {
  FadeRoute({
    required this.builder,
    this.transitionDuration = const Duration(
      microseconds: 300,
    ),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (isActive) {
      return FadeTransition(
        opacity: animation,
        child: builder(context),
      );
    } else {
      return Padding(padding: EdgeInsets.zero);
    }
  }
}
