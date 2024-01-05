import 'package:flutter/material.dart';

Widget defaultTextStyleMergeDemo() {
  return DefaultTextStyle(
    style: TextStyle(
        color: Colors.grey, fontSize: 24, fontWeight: FontWeight.bold),
    child: Column(
      children: <Widget>[
        //不使用合并，将样式定义为黑色斜体
        DefaultTextStyle(
            style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
            child: Text("落霞与孤鹜齐飞")),
        DefaultTextStyle.merge(
          //使用合并：将样式定义为黑色斜体
          style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
          child: Text("秋水共长天一色"),
        ),
      ],
    ),
  );
}
