import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/keep_alive_wrapper.dart';

class PageViewTestRoute extends StatelessWidget {
  const PageViewTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PageView')),
      body: KeepAliveTest(),
    );
  }
}

class PageViewTest1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var i = 0; i < 6; i++) {
      children.add(KeepAliveWrapper(child: Page(text: '$i')));
    }
    return PageView(
      allowImplicitScrolling: true,
      children: children,
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.text});

  final String text;

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    print('build ${widget.text}');
    return Center(
      child: Text(
        widget.text,
        textScaler: const TextScaler.linear(5.0),
      ),
    );
  }
}

class KeepAliveTest extends StatelessWidget {
  const KeepAliveTest({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (_, index) {
      return KeepAliveWrapper(keepAlive: false, child: ListItem(index: index));
    });
  }
}

class ListItem extends StatefulWidget {
  const ListItem({super.key, required this.index});

  final int index;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.index}'),
    );
  }

  @override
  void dispose() {
    print('dispose ${widget.index}');
    super.dispose();
  }
}
