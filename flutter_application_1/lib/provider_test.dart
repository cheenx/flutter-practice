import 'dart:collection';

import 'package:flutter/material.dart';

class Item {
  Item(this.price, this.count);

  double price; //商品单价
  int count; //商品份数
}

class CartModel extends ChangeNotifier {
  //用于保存购物车中的商品列表
  final List<Item> _items = [];

  //禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  //购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  //将【item】 添加到购物车，这是唯一一种能从外部改变购物车的方法
  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class ProviderTestRoute extends StatefulWidget {
  const ProviderTestRoute({super.key});

  @override
  State<ProviderTestRoute> createState() => _ProviderTestRouteState();
}

class _ProviderTestRouteState extends State<ProviderTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('provider test')),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(builder: (context) {
            return Column(
              children: [
                Consumer<CartModel>(builder: (context, cart) {
                  return Text('总价： ${cart?.totalPrice ?? 0.0}');
                }),
                Builder(builder: (context) {
                  print('ElevatedButton buld');
                  return ElevatedButton(
                      onPressed: () {
                        ChangeNotifierProvider.of<CartModel>(context,
                                listen: false)
                            ?.add(Item(20.0, 1));
                      },
                      child: Text('添加商品'));
                })
              ],
            );
          }),
        ),
      ),
    );
  }
}

class Consumer<T> extends StatelessWidget {
  const Consumer({super.key, required this.builder});

  final Widget Function(BuildContext context, T? value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, ChangeNotifierProvider.of<T>(context));
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({required this.data, required this.child});

  final Widget child;
  final T data;

  static T? of<T>(BuildContext context, {bool listen = true}) {
    // final type = _typeOf<InheritedProvider<T>>();
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>;
    return provider?.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    //当provider更新时，如果新旧数据不同，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(data: widget.data, child: widget.child);
  }
}

class InheritedProvider<T> extends InheritedWidget {
  const InheritedProvider({Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  final T data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    //在此简单的返回true，则每次更新都会调用依赖其的子孙节点’didChangeDependencies‘
    return true;
  }
}
