// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/domain/model/project_models/project_stats_model.dart';
import 'package:todo2/domain/model/project_models/projects_model.dart';
import 'package:todo2/domain/repository/projects_repository.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/providers/color_pallete_provider/color_pallete_provider.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/network_service/connection_checker.dart';

enum ProjectDialogStatus {
  add,
  edit,
  remove,
}

class ProjectController extends ChangeNotifier with ConnectionCheckerMixin {
  ProjectController({
    required this.colorPalleteProvider,
    required ProjectRepository projectsRepository,
  }) : _projectsRepository = projectsRepository;

  final ProjectRepository _projectsRepository;

  final ColorPalleteProvider colorPalleteProvider;

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
    colorPalleteProvider.changeSelectedIndex(99);
  }

  void findEditColor({required ProjectModel model}) {
    pickProject(pickedModel: model);
    for (int i = 0; i < colors.length; i++) {
      if (colors[i] == model.color) {
        colorPalleteProvider.changeSelectedIndex(i);
        break;
      }
    }
  }

  Future<void> tryValidateProject({
    required bool isEdit,
    required BuildContext context,
  }) async {
    setClickedValue(false);
    if (await isConnected()) {
      if (formKey.currentState!.validate() &&
          !colorPalleteProvider.isNotPickerColor) {
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
    } else {
      MessageService.displaySnackbar(
        message: LocaleKeys.no_internet.tr(),
        context: context,
      );
      setClickedValue(true);
    }
  }

  Future<void> fetchProjectStats() async {
    projectStats.value = await _projectsRepository.fetchProjectStats();
    projectStats.notifyListeners();
  }

  Future<List<ProjectModel>> fetchAllProjects() async {
    final list = await _projectsRepository.fetchAllProjects();
    projects.value = list;
    projects.notifyListeners();
    return list;
  }

  Future<void> createProject() async {
    final model = await _projectsRepository.createProject(
      color: colors[colorPalleteProvider.selectedIndex.value],
      title: titleController.text,
    );
    await fetchProjectStats();
    projects.value.add(model);
    projects.notifyListeners();
  }

  Future<void> updateProject({required ProjectModel projectModel}) async {
    final updatedModel = await _projectsRepository.updateProject(
      color: colors[colorPalleteProvider.selectedIndex.value],
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
  }

  Future<void> deleteProject({required BuildContext context}) async {
    setClickedValue(false);
    if (await isConnected()) {
      await _projectsRepository.deleteProject(
        projectModel: selectedModel!,
      );
      await fetchProjectStats().then((_) => MessageService.displaySnackbar(
            context: context,
            message: LocaleKeys.deleted.tr(),
          ));
      projects.value.removeWhere((element) => selectedModel!.id == element.id);
      projects.notifyListeners();

      clearProjects();

      await Future.delayed(Duration.zero, () => Navigator.pop(context));
    } else {
      MessageService.displaySnackbar(
        message: LocaleKeys.no_internet.tr(),
        context: context,
      );
    }
    setClickedValue(true);
  }
}
