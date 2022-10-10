import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

// TRANSLATE
class TaskValidator {
  Future<bool> tryValidate({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    try {
      FocusScope.of(context).unfocus();

      if (formKey.currentState!.validate()) {
        return true;
      } else {
        return false;
      }
    } catch (e, t) {
      log('trace $t');
      throw Failure(e.toString());
    }
  }

  bool isValidPickedDate(
    DateTime time,
    BuildContext context,
    bool useMessage,
  ) {
    if (time.day == DateTime.now().day || time.day < DateTime.now().day) {
      useMessage
          ? MessageService.displaySnackbar(
              context: context,
              message: 'You cant pick date before now!',
            )
          : null;
      return false;
    } else {
      return true;
    }
  }
}
