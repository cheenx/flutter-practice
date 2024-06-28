import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static showToast({
    required String msg,
    Toast? toastLength = Toast.LENGTH_LONG,
    double? fontSize,
    ToastGravity? gravity = ToastGravity.CENTER,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        fontSize: fontSize,
        gravity: gravity,
        backgroundColor: backgroundColor,
        textColor: textColor);
  }
}
