import 'package:flutter/cupertino.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/access_token_mixin.dart';

class ViewTaskController extends ChangeNotifier with AccessTokenMixin {
  final AttachmentsProvider attachmentsProvider;
  ViewTaskController({
    required this.attachmentsProvider,
  });
  Map<String, String>? imageHeader;
  
  final isActiveSubmitButton = ValueNotifier<bool>(true);

  final descriptionController = TextEditingController();

  void changeSubmitButton(bool newValue) {
    isActiveSubmitButton.value = newValue;
    isActiveSubmitButton.notifyListeners();
  }
}
