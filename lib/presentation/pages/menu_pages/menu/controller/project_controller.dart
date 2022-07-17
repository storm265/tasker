import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';

enum ProjectDialogStatus {
  add,
  edit,
  remove,
}

class ProjectController extends ChangeNotifier {
  ProjectController({
    required this.projectsRepository,
    required this.colorPalleteController,
  });
  final ProjectRepositoryImpl projectsRepository;
  final ColorPalleteController colorPalleteController;
  final formKey = GlobalKey<FormState>();
  final isClickedSubmitButton = ValueNotifier(true);
  final titleController = TextEditingController();

  final selectedModel = ValueNotifier(
    ProjectModel(
      color: '',
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

  Future<void> validate({required bool isEdit,required BuildContext context}) async {
    try {
      if (formKey.currentState!.validate()) {
        setClickedValue(false);
        if(titleController.text.length >= 3){
         final bool isDublicateProject = await findDublicates(context: context, title: titleController.text);
       if(!isDublicateProject){
         isEdit
                ? await projectsRepository.updateProject(
                    projectModel: selectedModel.value)
                : await projectsRepository.postProject(
                    projectModel: selectedModel.value);
       }
         
        }
        setClickedValue(true);
      }
    } catch (e) {
      ErrorService.printError('Error in validate(): $e');
    }
  }

  Future<List<ProjectModel>> fetchProjects() async {
    try {
      List<ProjectModel> projects = await projectsRepository.fetchProject();
      return projects;
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }

  Future<bool> findDublicates({required String title,required BuildContext context}) async {
    try {
      String foundTitle = await projectsRepository.findDublicates(title: title);
      if (title == foundTitle) {
        MessageService.displaySnackbar(context: context, message: 'This project is already exist');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }

  Future<void> postProject({required ProjectModel projectModel}) async {
    try {
      await projectsRepository.postProject(projectModel: projectModel);
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }

  Future<void> updateProject({
    required ProjectModel projectModel,
  }) async {
    try {
      await projectsRepository.updateProject(projectModel: projectModel);
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }

  Future<void> deleteProject({required ProjectModel projectModel}) async {
    try {
      await projectsRepository.deleteProject(projectModel: projectModel);
    } catch (e) {
      ErrorService.printError('Error in fetchProjects(): $e');
      rethrow;
    }
  }

  void disposeValues() {
    isClickedSubmitButton.dispose();
    selectedModel.dispose();
    titleController.dispose();
  }
}
