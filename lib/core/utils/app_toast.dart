import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/core/utils/enums.dart';

class AppToast {
  static showToast({required String msg, required RequestState state}) {
    Color color = Colors.yellow;
    if (state == RequestState.error) color = Colors.red;
    if (state == RequestState.success) color = Colors.green;
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
