import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget iconBaseDemo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Icon(
        Icons.refresh,
        size: 48,
        color: Colors.blue,
      ),
      Icon(
        Icons.star,
        semanticLabel: "内容已收藏",
      ),
      Icon(Icons.share),
      Icon(CupertinoIcons.share)
    ],
  );
}
