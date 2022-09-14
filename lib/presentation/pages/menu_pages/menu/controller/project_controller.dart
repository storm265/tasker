import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/project_stats_model.dart';
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

  final projects = ValueNotifier<List<ProjectModel>>([]);

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
    titleController.text = pickedModel.title;
    selectedModel.notifyListeners();
  }

  void setClickedValue(bool newValue) {
    isClickedSubmitButton.value = newValue;
    isClickedSubmitButton.notifyListeners();
  }

  void clearProjects() {
    titleController.clear();
    projects.value.clear();
    projects.notifyListeners();
    colorPalleteController.changeSelectedIndex(99);
  }

  Future<void> tryValidateProject({
    required bool isEdit,
    required BuildContext context,
    required VoidCallback callback,
  }) async {
    try {
      if (formKey.currentState!.validate() &&
          !colorPalleteController.isNotPickerColor) {
        setClickedValue(false);
        if (isEdit) {
          await updateProject(
            projectModel: selectedModel.value,
            title: titleController.text,
          );
        } else {
          await createProject(title: titleController.text);
        }
        clearProjects();
        colorPalleteController.changeSelectedIndex(99);
        await fetchAllProjects().then((_) {
          setClickedValue(true);
        });
        callback();
      }
    } catch (e, t) {
      log('tryValidateProject $e,$t');
      throw Failure(e.toString());
    }
  }

  Future<void> fetchAllProjects() async {
    try {
      projects.value = await _projectsRepository.fetchAllProjects();
      projects.notifyListeners();
    } catch (e) {
      debugPrint('error $e');
      throw Failure(e.toString());
    }
  }

  Future<List<ProjectStatsModel>> fetchProjectStats() async {
    try {
      final response = await _projectsRepository.fetchProjectStats();
      return response;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> createProject({
    required String title,
  }) async {
    try {
      await _projectsRepository.createProject(
        color: colors[colorPalleteController.selectedIndex.value],
        title: title,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateProject({
    required ProjectModel projectModel,
    required String title,
  }) async {
    try {
      await _projectsRepository.updateProject(
        color: colors[colorPalleteController.selectedIndex.value],
        projectModel: projectModel,
        title: title,
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  void findEditColor({required ProjectModel model}) {
    pickProject(pickedModel: model);
    for (int i = 0; i < colors.length; i++) {
      if (colors[i] == model.color) {
        colorPalleteController.changeSelectedIndex(i);
        break;
      }
    }
  }

  Future<void> deleteProject({
    required ProjectModel projectModel,
  }) async {
    try {
      setClickedValue(false);
      await _projectsRepository.deleteProject(projectModel: projectModel);
      clearProjects();
      colorPalleteController.changeSelectedIndex(99);
      await fetchAllProjects().then((_) {
        setClickedValue(true);
      });
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  void disposeValues() {
    projects.dispose();
    titleController.dispose();
    isClickedSubmitButton.dispose();
    selectedModel.dispose();
  }
}
