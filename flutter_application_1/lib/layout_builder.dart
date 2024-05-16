import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/after_layout.dart';

class LayoutBuilderTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layout Builder Test'),
        backgroundColor: Colors.blue,
      ),
      body: AfterLayoutRoute(),
    );
  }
}

class BuilderTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _children = List.filled(6, Text('A'));
    //Column在本实例中在水平方向的最大宽度为屏幕的宽度
    return Column(
      children: [
        SizedBox(
          width: 190.0,
          child: ResponsiveColumn(children: _children),
        ),
        ResponsiveColumn(children: _children),
        LayoutLogPrint(child: Text('xx')),
        AfterLayout(
          callback: (RenderAfterLayout ral) {
            print(ral.size);
            print(ral.offset);
          },
          child: Text('flutter@wendux'),
        )
      ],
    );
  }
}

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 200) {
        return Column(children: children, mainAxisSize: MainAxisSize.min);
      } else {
        var _children = <Widget>[];
        for (var i = 0; i < children.length; i += 2) {
          if (i + 1 < children.length) {
            _children.add(Row(
              children: [children[i], children[i + 1]],
              mainAxisSize: MainAxisSize.min,
            ));
          } else {
            children.add(children[i]);
          }
        }
        return Column(children: _children, mainAxisSize: MainAxisSize.min);
      }
    });
  }
}

class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({Key? key, this.tag, required this.child})
      : super(key: key);

  final Widget child;
  final T? tag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      assert(() {
        print('${tag ?? key ?? child} : $constraints');
        return true;
      }());
      return child;
    });
  }
}

class AfterLayoutTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        width: 100.0,
        height: 100.0,
        child: AfterLayout(
          callback: (ral) {
            Offset offset = ral.localToGlobal(Offset.zero,
                ancestor: context.findRenderObject());
            print('A 在Container 中占用的空间范围为： ${offset & ral.size}');
          },
          child: Text('A'),
        ),
      );
    });
  }
}

class AfterLayoutRoute extends StatefulWidget {
  const AfterLayoutRoute({Key? key}) : super(key: key);

  @override
  State<AfterLayoutRoute> createState() => _AfterLayoutRouteState();
}

class _AfterLayoutRouteState extends State<AfterLayoutRoute> {
  String _text = 'flutter 实战';
  Size _size = Size.zero;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Builder(builder: (context) {
            return GestureDetector(
              child: Text(
                'Text1: 点我获取我的大小',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () => print('text1: ${context.size}'),
            );
          }),
        ),
        AfterLayout(
          callback: (ral) {
            print('Text2: ${ral.size}, ${ral.offset}');
          },
          child: Text('Text2: flutter@wendux'),
        ),
        Builder(builder: (context) {
          return Container(
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            width: 100.0,
            height: 100.0,
            child: AfterLayout(
              callback: (ral) {
                Offset offset = ral.localToGlobal(Offset.zero,
                    ancestor: context.findRenderObject());
                print('A 在Container 中占用的空间的范围为: ${offset & ral.size}');
              },
              child: Text('A'),
            ),
          );
        }),
        Divider(),
        AfterLayout(
          callback: (ral) {
            setState(() {
              _size = ral.size;
            });
          },
          child: Text(_text),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Text size: $_size',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _text += 'flutter 实战';
              });
            },
            child: Text('追加字符串'))
      ],
    );
  }
}
