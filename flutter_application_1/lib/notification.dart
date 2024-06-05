import 'package:flutter/material.dart';

class NotifyTestRoute extends StatelessWidget {
  const NotifyTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify Test'),
      ),
      body: NotificationRoute(),
    );
  }
}

class NotificationTest extends StatelessWidget {
  const NotificationTest({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: (notification) {
          switch (notification.runtimeType) {
            case ScrollStartNotification:
              print('开始滚动');
              break;
            case ScrollUpdateNotification:
              print('正在滚动');
              break;
            case ScrollEndNotification:
              print('滚动停止');
              break;
            case OverscrollNotification:
              print('滚动到边界');
              break;
            default:
              break;
          }
          return false;
        },
        child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('$index'),
              );
            }));
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}

class NotificationRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationRouteState();
  }
}

class NotificationRouteState extends State<NotificationRoute> {
  String _msg = '';
  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        print(notification.msg);
        return true;
      },
      child: NotificationListener<MyNotification>(
          onNotification: (notification) {
            setState(() {
              _msg += notification.msg + " ";
            });
            return true;
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () => MyNotification('hi').dispatch(context),
                      child: Text('Send Notification'));
                }),
                Text(_msg)
              ],
            ),
          )),
    );
  }
}
