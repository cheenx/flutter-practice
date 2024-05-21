import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout_builder.dart';

class CliverTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliver Test'),
      ),
      body: ListViewBuilder1(),
    );
  }
}

class SingleChildScrollViewTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = 'ABCDEFHIJKLMNOPQRSTUVWXYZ';
    return Scrollbar(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children:
              //动态撞见一个List<Widget>
              str
                  .split('')
                  //每一个字母都用一个Text显示，字体为原来的两倍
                  .map((c) => Text(
                        c,
                        textScaler: TextScaler.linear(2.0),
                      ))
                  .toList(),
        ),
      ),
    ));
  }
}

class ListViewTest1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(20.0),
      children: [
        Text('I\'m dedicating every day to you'),
        Text('Domestic life was never quite my style'),
        Text('When you smile, you knock me out, I fall apart'),
        Text('And I thougnt I was so smart'),
      ],
    );
  }
}

class ListViewBuilder1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('商品列表'),
        ),
        Expanded(
            child: Scrollbar(
                child: ListView.builder(
                    prototypeItem: ListTile(
                      title: Text('1'),
                    ),
                    itemCount: 100,
                    // itemExtent: 50.0, //强制高度为50.0
                    itemBuilder: (context, index) {
                      return LayoutLogPrint(
                          tag: index,
                          child: ListTile(
                            title: Text('$index'),
                          ));
                    })))
      ],
    );
  }
}

class ListViewBuilder2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(
      color: Colors.green,
    );
    return Scrollbar(
        child: ListView.separated(
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('$index'),
        );
      },
      separatorBuilder: (context, index) {
        return index % 2 == 0 ? divider1 : divider2;
      },
    ));
  }
}

class InfiniteListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = '##loading##';
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _words.length,
      itemBuilder: (context, index) {
        if (_words[index] == loadingTag) {
          if (_words.length - 1 < 100) {
            _retrieveData();
            return Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: Text(
                '没有更多了',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
        } else {
          return ListTile(
            title: Text(_words[index]),
          );
        }
      },
      separatorBuilder: (context, index) => Divider(
        height: .0,
      ),
    );
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }
}
