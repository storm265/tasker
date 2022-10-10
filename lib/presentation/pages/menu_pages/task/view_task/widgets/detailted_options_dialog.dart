// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/storage/secure_storage_service.dart';

Future<void> showDetailedOptions({
  required BuildContext context,
  required TaskModel selectedTask,
}) async {
  final secureStorage = SecureStorageSource();
  final List<String> items = [
    LocaleKeys.add_member.tr(),
    LocaleKeys.edit_task.tr(),
    LocaleKeys.delete_task.tr(),
  ];
  bool isSameId(String storageId) => storageId == selectedTask.ownerId;
  await showDialog(
    barrierColor: Colors.black26,
    context: context,
    builder: (_) => Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 140,
          right: 40,
          top: 75,
        ),
        child: AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          alignment: Alignment.topRight,
          content: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: ((_, i) {
              return InkWell(
                onTap: () async {
                  final id =
                      await secureStorage.getUserData(type: StorageDataType.id);
                  switch (i) {
                    case 0:
                      if (isSameId(id!)) {
                        log('shish');
                      }
                      Navigator.pop(context);
                      break;
                    case 1:
                      Navigator.pop(context);
                      break;
                    case 2:
                      Navigator.pop(context);
                      break;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    items[i],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    ),
  );
}
