import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class SocketTestRoute extends StatelessWidget {
  const SocketTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socket'),
      ),
      body: SocketRoute(),
    );
  }
}

class SocketRoute extends StatelessWidget {
  const SocketRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _request(),
        builder: (context, snapshot) {
          return Text(snapshot.data.toString());
        });
  }

  _request() async {
    var socket = await Socket.connect("baidu.com", 80);

    socket.writeln("GET / HTTP/1.1");
    socket.writeln("Host:baidu.com");
    socket.writeln('Connection:close');
    socket.writeln();

    await socket.flush();

    String _response = await utf8.decoder.bind(socket).join();
    await socket.close();
    return _response;
  }
}
