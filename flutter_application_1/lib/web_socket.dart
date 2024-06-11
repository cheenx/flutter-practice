import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketRoute extends StatefulWidget {
  const WebSocketRoute({super.key});

  @override
  State<WebSocketRoute> createState() => _WebSocketRouteState();
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  TextEditingController _controller = TextEditingController();
  late WebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    channel =
        WebSocketChannel.connect(Uri.parse('wss://echo.websocket.events'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket（内容回显）'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
                child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'send a message'),
            )),
            StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    _text = '网络不通……';
                  } else if (snapshot.hasData) {
                    _text = "echo" + snapshot.data;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(_text),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        shape: CircleBorder(),
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
