import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/services/message_service/message_service.dart';

// TRANSLATE
class TaskValidator {
  final _now = DateTime.now();
  Future<bool> tryValidate({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required ProjectModel? pickedProject,
  }) async {
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate() &&
        isPickedProject(pickedProject: pickedProject)) {
      return true;
    } else {
      MessageService.displaySnackbar(
        context: context,
        message: 'Please select project',
      );
      await Future.delayed(const Duration(seconds: 3));
      return false;
    }
  }

  bool isPickedProject({ProjectModel? pickedProject}) {
    if (pickedProject == null) {
      return false;
    } else {
      return true;
    }
  }

  bool isValidPickedDate(
    DateTime pickedDate,
    BuildContext context,
    bool useMessage,
  ) {
    if (pickedDate.isAfter(_now)) {
      return true;
    } else {
      useMessage
          ? MessageService.displaySnackbar(
              context: context,
              message: 'You cant pick date before now!',
            )
          : null;
      return false;
    }
  }
}
