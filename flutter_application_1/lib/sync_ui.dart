import 'package:flutter/material.dart';

class SyncUiTestRoute extends StatelessWidget {
  const SyncUiTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sync UI Test'),
      ),
      body: SyncUITest2(),
    );
  }
}

Future<String> mockNetworkData() {
  return Future.delayed(Duration(seconds: 2), () => '我是从互联网上获取的数据');
}

class SyncUiTest1 extends StatelessWidget {
  const SyncUiTest1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<String>(
          future: mockNetworkData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Connects: ${snapshot.data}');
              }
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}

class SyncUITest2 extends StatelessWidget {
  const SyncUITest2({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: counter(),
        // initialData: -1,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('没有Stream');
            case ConnectionState.waiting:
              return Text('等待数据');
            case ConnectionState.active:
              return Text('active: ${snapshot.data}');
            case ConnectionState.done:
              return Text('Stream 关闭');
          }

          return Placeholder();
        });
  }
}
