import 'package:flutter/material.dart';

Widget textOverflowDemo() {
  final text =
      "Flutter is an open-source UI software development kit create by Google." +
          "It is used to develop applications for Android, iOS, Linux, Mac, Windows," +
          "Google Fuchsia and the web from a single codebase.";
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(margin: EdgeInsets.only(left: 8, right: 8), child: Text(text)),
      Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Text(
          text,
          overflow: TextOverflow.fade,
          maxLines: 2,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Text(
          text,
          overflow: TextOverflow.clip,
          maxLines: 2,
        ),
      ),
    ],
  );
}
