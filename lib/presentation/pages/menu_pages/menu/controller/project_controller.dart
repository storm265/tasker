import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
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
      id: '',
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
    required BuildContext context,
  }) async {
    try {
      if (formKey.currentState!.validate()) {
        setClickedValue(false);
        // final bool isDublicateProject = await findDublicates(
        //   title: title,
        //   context: context,
        // );
        // if (!isDublicateProject) {
        //   isEdit
        //       ? await _projectsRepository.updateProject(
        //           color: selectedModel.value.color,
        //           title: title,
        //         )
        //       : await createProject(
        //           context: context,
        //           color: colors[colorPalleteController.selectedIndex.value],
        //           title: title,
        //         );
        // }
        isEdit
            ? await _projectsRepository.updateProject(
                color: selectedModel.value.color,
                title: title,
              )
            : await createProject(
                context: context,
                color: colors[colorPalleteController.selectedIndex.value],
                title: title,
              );
        setClickedValue(true);
        onSuccessCallback();
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<List<ProjectModel>> fetchAllProjects() async {
    try {
      final projects = await _projectsRepository.fetchAllProjects();
      print('projects $projects');
      return projects;
    } catch (e) {
      debugPrint('error $e');
      throw Failure(e.toString());
    }
  }

  // Future<bool> findDublicates({
  //   required String title,
  //   required BuildContext context,
  // }) async {
  //   bool isDublicated =
  //       await _projectsRepository.isDublicatedProject(title: title);
  //   if (isDublicated) {
  //     MessageService.displaySnackbar(
  //       message: 'This project is already exist',
  //       context: context,
  //     );
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<void> createProject({
    required Color color,
    required String title,
    required BuildContext context,
  }) async {
    try {
      await _projectsRepository.createProject(color: color, title: title);
    } catch (e) {
      MessageService.displaySnackbar(message: e.toString(), context: context);
      throw Failure(e.toString());
    }
  }

  Future<void> updateProject({
    required Color color,
    required String title,
    required BuildContext context,
  }) async {
    try {
      await _projectsRepository.updateProject(
        color: color,
        title: title,
      );
    } catch (e) {
      MessageService.displaySnackbar(message: e.toString(), context: context);
      throw Failure(e.toString());
    }
  }

  Future<void> deleteProject({
    required ProjectModel projectModel,
    required BuildContext context,
  }) async {
    try {
      await _projectsRepository.deleteProject(projectModel: projectModel);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  void disposeValues() {
    titleController.dispose();
    isClickedSubmitButton.dispose();
    selectedModel.dispose();
  }
}
