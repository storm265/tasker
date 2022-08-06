import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

enum ProjectDialogStatus {
  add,
  edit,
  remove,
}

class ProjectController extends ChangeNotifier {
  ProjectController(
    this._projectsRepository,
    this.colorPalleteController,
  );
  final ProjectRepositoryImpl _projectsRepository;
  final ColorPalleteController colorPalleteController;
  final formKey = GlobalKey<FormState>();
  final isClickedSubmitButton = ValueNotifier(true);
  final titleController = TextEditingController();
  final selectedModel = ValueNotifier(
    ProjectModel(
      color: Colors.red,
      createdAt: '',
      title: '',
      ownerId: '',
    ),
  );

  void pickProject({required ProjectModel pickedModel}) {
    selectedModel.value = pickedModel;
    selectedModel.notifyListeners();
  }

  void setClickedValue(bool newValue) {
    isClickedSubmitButton.value = newValue;
    isClickedSubmitButton.notifyListeners();
  }


  Future<void> validate({
    required bool isEdit,
    required BuildContext context,
    required String title,
    required VoidCallback onSuccessCallback,
    required String oldTitle,
  }) async {
    try {
      if (formKey.currentState!.validate()) {
        setClickedValue(false);
        final bool isDublicateProject =
            await findDublicates(context: context, title: title);
        if (!isDublicateProject) {
          isEdit
              ? await _projectsRepository.updateProject(
                  oldTitle: oldTitle,
                  color: selectedModel.value.color,
                  title: title,
                )
              : await _projectsRepository.createProject(
                  color: colors[colorPalleteController.selectedIndex.value]
                    ,
                  title: title,
                );
        }

        setClickedValue(true);
        onSuccessCallback();
      }
    } catch (e, t) {
      ErrorService.printError('Error in validate(): $e, trace: $t');
    }
  }

  Future<Map<String, dynamic>> fetchProjects() async {
    try {
      final projects = await _projectsRepository.fetchOneProject();
      return projects;
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }

  Future<bool> findDublicates({
    required String title,
    required BuildContext context,
  }) async {
    try {
      String foundTitle =
          await _projectsRepository.findDublicates(title: title);
      if (title.trim() == foundTitle.trim()) {
        MessageService.displaySnackbar(
          message: 'This project is already exist',
        );
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ErrorService.printError('Error in findDublicates(): $e');
      rethrow;
    }
  }

  Future<void> pushProject({
    required Color color,
    required String title,
  }) async {
    try {
      await _projectsRepository.createProject(color: color, title: title);
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }

  Future<void> updateProject({
    required Color color,
    required String title,
    required String oldTitle,
  }) async {
    try {
      await _projectsRepository.updateProject(
        color: color,
        title: title,
        oldTitle: oldTitle,
      );
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }

  Future<void> deleteProject({required ProjectModel projectModel}) async {
    try {
      await _projectsRepository.deleteProject(projectModel: projectModel);
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }

  void disposeValues() {
    titleController.dispose();
    isClickedSubmitButton.dispose();
    selectedModel.dispose();
  }
}
