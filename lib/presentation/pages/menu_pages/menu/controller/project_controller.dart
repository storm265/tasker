import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';

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
      createdAt: DateTime.now(),
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
    required String title,
    required VoidCallback onSuccessCallback,
  }) async {
    try {
      if (formKey.currentState!.validate()) {
        setClickedValue(false);
        final bool isDublicateProject = await findDublicates(title: title);
        if (!isDublicateProject) {
          isEdit
              ? await _projectsRepository.updateProject(
                  color: selectedModel.value.color,
                  title: title,
                )
              : await _projectsRepository.createProject(
                  color: colors[colorPalleteController.selectedIndex.value],
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

  Future<BaseListResponse<ProjectModel>> fetchAllProjects() async {
    final projects = await _projectsRepository.fetchAllProjects();
    return projects;
  }

  Future<bool> findDublicates({required String title}) async {
    bool isDublicated =
        await _projectsRepository.isDublicatedProject(title: title);
    if (isDublicated) {
      MessageService.displaySnackbar(message: 'This project is already exist');
      return true;
    } else {
      return false;
    }
  }

  Future<void> createProject({
    required Color color,
    required String title,
  }) async {
    await _projectsRepository.createProject(color: color, title: title);
  }

  Future<void> updateProject({
    required Color color,
    required String title,
  }) async {
    await _projectsRepository.updateProject(
      color: color,
      title: title,
    );
  }

  Future<void> deleteProject({required ProjectModel projectModel}) async {
    await _projectsRepository.deleteProject(projectModel: projectModel);
  }

  void disposeValues() {
    titleController.dispose();
    isClickedSubmitButton.dispose();
    selectedModel.dispose();
  }
}
