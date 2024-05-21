import 'package:flutter/material.dart';

class AnimatedListTestRoute extends StatefulWidget {
  const AnimatedListTestRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedListTestState();
}

class _AnimatedListTestState extends State<AnimatedListTestRoute> {
  var data = <String>[];
  int counter = 5;

  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for (var i = 0; i < counter; i++) {
      data.add('${i + 1}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated List Test'),
      ),
      body: Stack(
        children: [
          AnimatedList(
              key: globalKey,
              initialItemCount: data.length,
              itemBuilder: (context, index, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: buildItem(context, index),
                );
              }),
          buildAddBtn()
        ],
      ),
    );
  }

  Widget buildAddBtn() {
    return Positioned(
      child: FloatingActionButton(
        child: Icon(Icons.add),
        shape: CircleBorder(),
        onPressed: () {
          data.add('${++counter}');
          globalKey.currentState!.insertItem(data.length - 1);
          print('添加 $counter');
        },
      ),
      bottom: 30,
      left: 0,
      right: 0,
    );
  }

  Widget buildItem(BuildContext context, int index) {
    String char = data[index];
    return ListTile(
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => onDelete(context, index),
      ),
    );
  }

  void onDelete(BuildContext context, int index) {
    setState(() {
      globalKey.currentState!.removeItem(index, (context, animation) {
        //删除过程执行的是反向动画，animation.value会从1变成0
        var item = buildItem(context, index);
        print('删除 ${data[index]}');
        data.removeAt(index);
        //删除动画是一个合成动画：渐隐+收缩列表项
        return FadeTransition(
          opacity: CurvedAnimation(
              parent: animation,
              //让透明度变化的更快一些
              curve: Interval(0.5, 1.0)),
          //不断缩小列表的高度
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: 0.0,
            child: item,
          ),
        );
      }, duration: Duration(milliseconds: 200));
    });
  }
}
