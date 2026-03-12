import 'package:flutter/material.dart';

class ToastUtils {
  // 阀门控制
  static bool _isShow = false;
  static void showToast(BuildContext context, String? msg) {
    if (_isShow) {
      return;
    }
    _isShow = true;

    Future.delayed(Duration(seconds: 3), () {
      _isShow = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg ?? "加载成功", textAlign: TextAlign.center),
        width: 190,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
