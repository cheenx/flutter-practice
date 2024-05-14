import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CupertinoTestRoute(),
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
        child: Echo(text: 'hello world'),
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
