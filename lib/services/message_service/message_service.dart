import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: message,
          contentType: ContentType.failure,
        ),
        duration: Duration(milliseconds: milliseconds),
      ),
    );
  }
}
