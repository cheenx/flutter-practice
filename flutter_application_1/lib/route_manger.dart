import 'package:flutter/material.dart';

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Manager'),
      ),
      body: Center(
        child: Text('This is new route'),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  const TipRoute({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('提示')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
            child: Column(
          children: [
            Text(text),
            ElevatedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: const Text('返回'))
          ],
        )),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            // var result = await Navigator.push(context,
            //     MaterialPageRoute(builder: (context) {
            //   return TipRoute(text: '我是提示xxxx');
            // }));
            var result = await Navigator.of(context)
                .pushNamed('tip2', arguments: '我是提示页----');
            print('路由返回值 $result');
          },
          child: Text('打开提示页')),
    );
  }
}

class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var args = ModalRoute.of(context)?.settings.arguments;
    print('args = $args');
    return Scaffold(
      appBar: AppBar(
        title: Text('Echo Route'),
      ),
      body: Center(
        child: Text('This is Echo'),
      ),
    );
  }
}
