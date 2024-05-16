import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/asset_manager.dart';
import 'package:flutter_application_1/child_layout.dart';
import 'package:flutter_application_1/linear_layout.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/pack_manager.dart';
import 'package:flutter_application_1/route_manger.dart';
import 'package:flutter_application_1/state_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // child: Echo(text: 'hello world'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return RouterTestRoute();
                  // }));
                  // Navigator.pushNamed(context, 'new_page');
                  Navigator.of(context).pushNamed('linear_layout');
                },
                child: Text('open new route'))
          ],
        ),
      ),
    );
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
