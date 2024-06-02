import 'package:flutter/material.dart';

class ValueListenableRoute extends StatefulWidget {
  const ValueListenableRoute({super.key});

  @override
  State<ValueListenableRoute> createState() => _ValueListenableRouteState();
}

class _ValueListenableRouteState extends State<ValueListenableRoute> {
  //定义一个ValueNotifier，当数字变化时会通知ValueListenableBuilder
  final ValueNotifier<int> _counter = ValueNotifier(0);
  static const double textScaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(title: Text('ValueListenableBuilder Test')),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: _counter,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child!,
                Text(
                  '$value 次',
                  textScaleFactor: textScaleFactor,
                )
              ],
            );
          },
          child: const Text(
            '点击了 ',
            textScaleFactor: textScaleFactor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () => _counter.value += 1,
        child: const Icon(Icons.add),
      ),
    );
  }
}
