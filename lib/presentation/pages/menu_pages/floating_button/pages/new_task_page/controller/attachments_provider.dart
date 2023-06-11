import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo2/domain/repository/task_repository.dart';
import 'package:todo2/presentation/providers/file_provider.dart';

class AttachmentsProvider extends ChangeNotifier {
  final TaskRepository taskRepository;
  final FileProvider fileProvider;

  AttachmentsProvider({
    required this.taskRepository,
    required this.fileProvider,
  });

  bool hasAttachments() => attachments.value.isEmpty ? false : true;
  final attachments = ValueNotifier<List<PlatformFile>>([]);

  void addAttachment({required PlatformFile attachment}) {
    attachments.value.add(attachment);
    attachments.notifyListeners();
  }

  void removeAttachment(int index) {
    attachments.value.removeAt(index);
    attachments.notifyListeners();
  }

  void clearAllAttachments() {
    attachments.value.clear();
    attachments.notifyListeners();
  }

  Future<void> uploadTaskAttachment({required String taskId}) async {
    for (int i = 0; i < attachments.value.length; i++) {
      await taskRepository.uploadTaskAttachment(
        name: attachments.value[i].name,
        file: File(attachments.value[i].path ?? ""),
        taskId: taskId,
        isFile: fileProvider.isValidImageFormat(attachments.value[i].name)
            ? false
            : true,
      );
    }
  }
}
