import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowMessage {
  static void toast(String message, {Color? color}) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: color,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 16);
  }
}
