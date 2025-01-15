import 'package:flutter/material.dart';

Future<void> showUpDis(context, String mess, String message) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        title: Text(mess),
        content: Text(message),
      );
    },
  );
}