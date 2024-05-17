import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout_builder.dart';
import 'package:flutter_application_1/widgets/single_line_fitted_box.dart';

class FittedBoxTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitted Box Test'),
        backgroundColor: Colors.blue,
      ),
      body: FittedBoxTest(),
    );
  }
}

class FittedBoxTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Row(
            children: [Text('xx' * 30)],
          ),
        ),
        Center(
          child: Column(
            children: [
              wContainer(BoxFit.none),
              Text('Wendux'),
              wContainer(BoxFit.contain),
              Text('Flutter中国'),
            ],
          ),
        ),
        Center(
            child: Column(
                children: [
          LayoutLogPrint(child: wRow(' 900000000000000000 '), tag: 1),
          SingleLineFittedBox(
            child: LayoutLogPrint(child: wRow(' 900000000000000000 '), tag: 2),
          ),
          LayoutLogPrint(child: wRow(' 800 '), tag: 3),
          SingleLineFittedBox(
            child: LayoutLogPrint(child: wRow(' 800 '), tag: 4),
          ),
        ]
                    .map((e) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: e,
                        ))
                    .toList())),
      ],
    );
  }
}

Widget wRow(String text) {
  Widget child = Text(text);
  child = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [child, child, child],
  );
  return child;
}

Widget wContainer(BoxFit boxFit) {
  return ClipRect(
    child: Container(
      width: 50.0,
      height: 50.0,
      color: Colors.red,
      child: FittedBox(
        fit: boxFit,
        child: Container(
          width: 60.0,
          height: 70.0,
          color: Colors.blue,
        ),
      ),
    ),
  );
}
