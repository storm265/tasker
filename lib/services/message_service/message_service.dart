import 'package:flutter/material.dart';

class MessageService {
  static GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  static displaySnackbar({
    required String message,
    int milliseconds = 2500,
  }) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        elevation: 0,
        margin: const EdgeInsets.only(
          bottom: 500,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black.withOpacity(0.8),
          ),
          child: Center(
            child: Text(message),
          ),
        ),
        duration: Duration(milliseconds: milliseconds),
      ),
    );
  }
}
