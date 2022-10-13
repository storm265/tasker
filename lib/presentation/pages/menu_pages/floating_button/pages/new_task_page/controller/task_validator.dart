import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo2/services/message_service/message_service.dart';

// TRANSLATE
class TaskValidator {
  final now = DateTime.now();
  final timeFormatter = DateFormat("MM");
  Future<bool> tryValidate({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
  }) async {
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidPickedDate(
    DateTime pickedDate,
    BuildContext context,
    bool useMessage,
  ) {
    if (pickedDate.isAfter(now)) {
      return true;
    } else {
      useMessage
          ? MessageService.displaySnackbar(
              context: context, // TRANSLATE
              message: 'You cant pick date before now!',
            )
          : null;
      return false;
    }
  }
}
