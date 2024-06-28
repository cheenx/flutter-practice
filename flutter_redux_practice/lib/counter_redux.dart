import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart' show Store;

enum Actions { Increment }

int counterReducer(int state, dynamic action) {
  return action == Actions.Increment ? state + 1 : state;
}

void main() {
  final store = Store<int>(counterReducer, initialState: 0);
  runApp(FlutterReduxApp(
    title: "Flutter Redux Demo",
    store: store,
  ));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<int>? store;
  final String? title;
  const FlutterReduxApp({super.key, this.store, this.title});

  @override
  Widget build(BuildContext context) {
    /// StoreProvider 应封装您的 MaterialApp 或 WidgetsApp。这将确保所有路由都能访问store。
    return StoreProvider<int>(
        store: store!,
        child: MaterialApp(
          theme: ThemeData.dark(),
          title: title!,
          home: Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StoreConnector<int, String>(
                    converter: (store) => store.state.toString(),
                    builder: (context, count) {
                      return Text(
                        'The button has been pushed this many times: $count',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18.0),
                      );
                    },
                  )
                ],
              ),
            ),
            floatingActionButton: StoreConnector<int, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(Actions.Increment);
              },
              builder: (context, callback) {
                return FloatingActionButton(
                  onPressed: callback,
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                  shape: const CircleBorder(),
                );
              },
            ),
          ),
        ));
  }
}
