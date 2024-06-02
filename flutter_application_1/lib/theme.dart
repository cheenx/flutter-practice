import 'package:flutter/material.dart';

class ThemeTestRoute extends StatelessWidget {
  const ThemeTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Test'),
      ),
      body: NavBarTest(),
    );
  }
}

class NavBarTest extends StatelessWidget {
  const NavBarTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavBar(color: Colors.blue, title: '标题'),
        SizedBox(
          height: 20.0,
        ),
        NavBar(color: Colors.white, title: '标题'),
      ],
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.color, required this.title});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    print('colorLight = ${color.computeLuminance()}');

    return Container(
      constraints: BoxConstraints(minHeight: 52.0, minWidth: double.infinity),
      decoration: BoxDecoration(color: color, boxShadow: [
        BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 3)
      ]),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color:
                color.computeLuminance() < 0.5 ? Colors.white : Colors.black),
      ),
      alignment: Alignment.center,
    );
  }
}

class ThemeTestRoute1 extends StatefulWidget {
  const ThemeTestRoute1({super.key});

  @override
  State<ThemeTestRoute1> createState() => _ThemeTestRoute1State();
}

class _ThemeTestRoute1State extends State<ThemeTestRoute1> {
  var _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
        data: ThemeData(
            primarySwatch: _themeColor,
            iconTheme: IconThemeData(color: _themeColor),
            appBarTheme: AppBarTheme(backgroundColor: _themeColor)),
        child: Scaffold(
          appBar: AppBar(
            title: Text('主题测试'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text('  颜色跟随主题')
                ],
              ),
              Theme(
                  data: themeData.copyWith(
                      iconTheme:
                          themeData.iconTheme.copyWith(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite),
                      Icon(Icons.airport_shuttle),
                      Text('  颜色固定黑色')
                    ],
                  ))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
              setState(() {
                _themeColor =
                    _themeColor == Colors.teal ? Colors.blue : Colors.teal;
              });
            },
            child: Icon(Icons.palette),
          ),
        ));
  }
}
