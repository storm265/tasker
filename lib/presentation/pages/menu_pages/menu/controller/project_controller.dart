import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/model/project_models/project_stats_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
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
    ),
  );

  final colorPalleteController = ColorPalleteController();

  final formKey = GlobalKey<FormState>();

  final isActiveSubmitButton = ValueNotifier(true);

  final titleController = TextEditingController();

  final projects = ValueNotifier<List<ProjectModel>>([]);
  final projectStats = ValueNotifier<List<ProjectStatsModel>>([]);

  ProjectModel? selectedModel;

  void pickProject({required ProjectModel pickedModel}) {
    selectedModel = pickedModel;
    titleController.text = pickedModel.title;
  }

  void setClickedValue(bool newValue) {
    isActiveSubmitButton.value = newValue;
    isActiveSubmitButton.notifyListeners();
  }

  void clearProjects() {
    titleController.clear();
    colorPalleteController.changeSelectedIndex(99);
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

  Future<void> tryValidateProject({
    required bool isEdit,
    required BuildContext context,
  }) async {
    try {
      if (formKey.currentState!.validate() &&
          !colorPalleteController.isNotPickerColor) {
        setClickedValue(false);
        if (isEdit) {
          await updateProject(projectModel: selectedModel!);
          MessageService.displaySnackbar(
            context: context,
            message: LocaleKeys.updated.tr(),
          );
        } else {
          await createProject();
          MessageService.displaySnackbar(
            context: context,
            message: LocaleKeys.created.tr(),
          );
        }
        clearProjects();
        setClickedValue(true);
        await Future.delayed(Duration.zero, () => Navigator.pop(context));
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> fetchProjectStats() async {
    try {
      projectStats.value = await _projectsRepository.fetchProjectStats();
      projectStats.notifyListeners();
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

  Future<void> createProject() async {
    try {
      final model = await _projectsRepository.createProject(
        color: colors[colorPalleteController.selectedIndex.value],
        title: titleController.text,
      );
      await fetchProjectStats();
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

  Future<void> deleteProject({required BuildContext context}) async {
    try {
      setClickedValue(false);
      await _projectsRepository.deleteProject(
        projectModel: selectedModel!,
      );
      await fetchProjectStats();
      projects.value.removeWhere((element) => selectedModel!.id == element.id);
      projects.notifyListeners();

      MessageService.displaySnackbar(
        context: context,
        message: LocaleKeys.deleted.tr(),
      );
      clearProjects();
      await Future.delayed(Duration.zero, () => Navigator.pop(context));
    } catch (e) {
      throw Failure(e.toString());
    } finally {
      setClickedValue(true);
    }
  }
}
