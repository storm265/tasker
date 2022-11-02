import 'package:flutter/material.dart';

class MessageService {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      displaySnackbar({
    required BuildContext context,
    required String message,
    int milliseconds = 2500,
  }) {
    FocusScope.of(context).unfocus();
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.only(bottom: 600),
        elevation: 0,
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
            child: Text(
              message,
              maxLines: null,
            ),
          ),
        ),
        duration: Duration(milliseconds: milliseconds),
      ),
    );
  }
}
