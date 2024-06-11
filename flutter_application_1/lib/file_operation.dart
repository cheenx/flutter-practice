import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileOperationTestRoute extends StatelessWidget {
  const FileOperationTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Operation Test')),
      body: FileOperationRoute(),
    );
  }
}

class FileOperationRoute extends StatefulWidget {
  const FileOperationRoute({super.key});

  @override
  State<FileOperationRoute> createState() => _FileOperationRouteState();
}

class _FileOperationRouteState extends State<FileOperationRoute> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      //读取点击次数（以字符串）
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  _incrementCounter() async {
    setState(() {
      _counter++;
    });

    await (await _getLocalFile()).writeAsString('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('文件操作'),
      ),
      body: Center(
        child: Text('点击了 $_counter 次'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        shape: CircleBorder(),
        tooltip: 'Increamt',
        child: Icon(Icons.add),
      ),
    );
  }
}
