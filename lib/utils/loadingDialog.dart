import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loadingdialog {
  static show(BuildContext content, {String? message = '加载中'}) {
    showDialog(
      context: content,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text(message ?? '加载中'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static hide(BuildContext content) {
    Navigator.pop(content);
  }
}
