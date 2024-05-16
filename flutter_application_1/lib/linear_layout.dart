import 'package:flutter/material.dart';

class LinearLayoutTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Linear Layout Route'),
        backgroundColor: Colors.blue,
      ),
      body: OtherTest(),
    );
  }
}

class RowTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      //测试Row对齐方式，排除Column默认居中对齐的干扰
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hello world'),
            Text('I am jack'),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('hello world'), Text('I am Jack')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          textDirection: TextDirection.rtl,
          children: [Text('hello world'), Text('I am Jack')],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.up,
          children: [
            Text(
              'hello world',
              style: TextStyle(fontSize: 32.0),
            ),
            Text('I am Jack')
          ],
        )
      ],
    );
  }
}

class OtherTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Container(
              color: Colors.red,
              child: Column(
                mainAxisSize: MainAxisSize.max, //无效，内层Column高度为实际高度
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('hello world'), Text('I am Jack')],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
