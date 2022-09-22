import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/model/project_models/project_stats_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

enum ProjectDialogStatus {
  add,
  edit,
  remove,
}

class ProjectController extends ChangeNotifier {
  final _projectsRepository = ProjectRepositoryImpl(
      projectDataSource: ProjectUserDataImpl(
    secureStorageService: SecureStorageSource(),
    network: NetworkSource(),
  ));

  final colorPalleteController = ColorPalleteController();

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
    colorPalleteController.changeSelectedIndex(99);
  }

  Future<void> tryValidateProject({
    required bool isEdit,
  }) async {
    try {
      if (formKey.currentState!.validate() &&
          !colorPalleteController.isNotPickerColor) {
        setClickedValue(false);
        if (isEdit) {
          await updateProject(projectModel: selectedModel.value);
        } else {
          await createProject();
        }
        clearProjects();
        setClickedValue(true);
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<List<ProjectModel>> fetchAllProjects() async {
    try {
      final list = await _projectsRepository.fetchAllProjects();
      projects.value = list;
      projects.notifyListeners();
      return list;
    } catch (e) {
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

  Future<void> createProject() async {
    try {
      final model = await _projectsRepository.createProject(
        color: colors[colorPalleteController.selectedIndex.value],
        title: titleController.text,
      );
      projects.value.add(model);
      projects.notifyListeners();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<List<ProjectModel>> searchProject({required String title}) async =>
      _projectsRepository.searchProject(title: title);

  Future<void> updateProject({required ProjectModel projectModel}) async {
    try {
      final updatedModel = await _projectsRepository.updateProject(
        color: colors[colorPalleteController.selectedIndex.value],
        projectModel: projectModel,
        title: titleController.text,
      );
      for (var i = 0; i < projects.value.length; i++) {
        if (projects.value[i].id == updatedModel.id) {
          projects.value[i] = updatedModel;
          projects.notifyListeners();
          break;
        }
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> deleteProject() async {
    try {
      setClickedValue(false);
      await _projectsRepository.deleteProject(
          projectModel: selectedModel.value);
      projects.value
          .removeWhere((element) => selectedModel.value.id == element.id);
      projects.notifyListeners();
      clearProjects();
      setClickedValue(true);
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
}
