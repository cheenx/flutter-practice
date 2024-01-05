import 'package:flutter/material.dart';

Widget DefaultTextStyleDemo() {
  return DefaultTextStyle(
      style: TextStyle(
          color: Colors.grey, //灰色
          fontWeight: FontWeight.bold //粗体
          ),
      textAlign: TextAlign.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("明月即使有"),
          Text("把酒问青天"),
          Text(
            "不知天上宫阙",
            style: TextStyle(
                //单独设置样式
                color: Colors.black, //黑色
                fontStyle: FontStyle.italic //斜体
                ),
          ),
          Text("今夕是何年"),
        ],
      ));
}
