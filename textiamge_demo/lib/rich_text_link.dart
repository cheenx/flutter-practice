import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Widget richTextLinkDemo() {
  return RichText(
      text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 18),
          children: [
        TextSpan(text: "我已阅读"),
        TextSpan(
          style: TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.underline,
          ),
          text: "使用条款",
          recognizer: TapGestureRecognizer()
            ..onTap = () => print("检测到用户单击使用条款"),
        ),
        TextSpan(text: "和"),
        TextSpan(
            style: TextStyle(
                color: Colors.grey, decoration: TextDecoration.underline),
            text: "隐私政策",
            recognizer: TapGestureRecognizer()
              ..onTap = (() => print("检测到用户单击隐私政策"))),
        TextSpan(text: "。")
      ]));
}
