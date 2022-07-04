import 'package:flutter/cupertino.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';

class AddProjectDialogController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final _projectsRepository = ProjectRepositoryImpl();
  final colorPalleteController = ColorPalleteController();
  final isClickedButton = ValueNotifier(true);
  final titleController = TextEditingController();

  void setClickedValue(bool newValue) {
    isClickedButton.value = newValue;
    isClickedButton.notifyListeners();
  }

  Future<void> validate() async {
    try {
      if (formKey.currentState!.validate()) {
        setClickedValue(false);
        (titleController.text.length >= 3)
            ? await _projectsRepository.putData(
                color: colors[colorPalleteController.selectedIndex.value]
                    .value
                    .toString(),
                title: titleController.text)
            : null;
        setClickedValue(true);
      }
    } catch (e) {
      ErrorService.printError('Error in validate(): $e');
    }
  }
}
