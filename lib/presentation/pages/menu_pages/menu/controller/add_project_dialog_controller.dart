import 'package:flutter/cupertino.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

class AddProjectDialogController extends ChangeNotifier {
  // TODO dependency

  final formKey = GlobalKey<FormState>();
  final _projectsRepository = ProjectRepositoryImpl();
  final colorPalleteController = ColorPalleteController();
  final isClickedButton = ValueNotifier(true);
  final titleController = TextEditingController();

final  selectedModel  = ValueNotifier
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

  Future<List<ProjectModel>> fetchProjects() async {
    try {
      List<ProjectModel> projects = await _projectsRepository.fetchProject();
      return projects;
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }

  Future<void> updateProject({
    required ProjectModel projectModel,
  }) async {
    try {
      await _projectsRepository.updateProject(projectModel: projectModel);
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }

  Future<void> deleteProject({required int id}) async {
    try {
      await _projectsRepository.deleteProject(id: id);
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }
}
