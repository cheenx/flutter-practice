import 'package:flutter/material.dart';

class InheritedWidgetTestRoute extends StatefulWidget {
  const InheritedWidgetTestRoute({super.key});

  @override
  State<InheritedWidgetTestRoute> createState() =>
      _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InheritedView Text'),
      ),
      body: Center(
        child: ShareDataWidget(
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: _TestWidget(),
              ),
              ElevatedButton(
                  onPressed: () => setState(() {
                        ++count;
                      }),
                  child: Text('Increment'))
            ],
          ),
        ),
      ),
    );
  }
}

class _TestWidget extends StatefulWidget {
  const _TestWidget({super.key});

  @override
  State<_TestWidget> createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    // return Text(ShareDataWidget.of(context)!.data.toString());
    return Text('text');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变（updateShouldNotify返回true）时会被调用
    //如果build中没有依赖InheritedWidget, 则此回调不会被调用
    print('dependencies change');
  }
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  final int data; //需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget != data;
  }
}
