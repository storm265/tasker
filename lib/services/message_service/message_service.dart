import 'package:flutter/material.dart';

class MessageService {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      displaySnackbar({
    required BuildContext context,
    required String message,
    int milliseconds = 2000,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        backgroundColor: Colors.black,
        content: Text(message),
        duration: Duration(milliseconds: milliseconds),
      ),
    );
  }
}
