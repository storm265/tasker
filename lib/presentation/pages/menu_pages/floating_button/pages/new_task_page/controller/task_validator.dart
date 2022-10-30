import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/services/message_service/message_service.dart';

class TaskValidator {
  final _now = DateTime.now();
  Future<bool> tryValidate({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required ProjectModel? pickedProject,
    required DateTime pickedDate,
  }) async {
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate() &&
        isPickedProject(pickedProject: pickedProject) && isValidPickedDate(pickedDate, context, true,)) {
      return true;
    } else {
      MessageService.displaySnackbar(
        context: context,
        message:LocaleKeys.please_select_project.tr(),
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
              message:LocaleKeys.you_cant_pick_date_debore_now.tr(),
            )
          : null;
      return false;
    }
  }
}
