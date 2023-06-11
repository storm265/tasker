import 'package:flutter/material.dart';
import 'package:todo2/domain/model/profile_models/users_profile_model.dart';
import 'package:todo2/domain/model/project_models/projects_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/member_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/panel_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_validator.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/tasks_mixin.dart';
import 'package:todo2/presentation/pages/menu_pages/task/tasks_widgets/calendar_lib/controller.dart';
import 'package:todo2/services/secure_storage_service.dart';

abstract class BaseTasks extends ChangeNotifier with TasksMixin {
  final AttachmentsProvider attachmentsProvider;
  final TaskValidator taskValidator;
  final PanelProvider panelProvider;
  final MemberProvider memberProvider;

  final SecureStorageSource secureStorage;
  BaseTasks({
    required this.taskValidator,
    required this.attachmentsProvider,
    required this.secureStorage,
    required this.panelProvider,
    required this.memberProvider,
  });

  final formKey = GlobalKey<FormState>();

  final AdvancedCalendarController calendarController =
      AdvancedCalendarController.today();

  final userTextController = TextEditingController();
  final projectTextController = TextEditingController();

  final memberTextController = TextEditingController();
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  final isActiveSubmitButton = ValueNotifier<bool>(true);
  void changeSubmitButton(bool newValue) {
    isActiveSubmitButton.value = newValue;
    isActiveSubmitButton.notifyListeners();
  }

  final pickedProject = ValueNotifier<ProjectModel?>(null);

  void pickProject({
    required ProjectModel newProject,
    required BuildContext context,
  }) {
    pickedProject.value = newProject;
    projectTextController.text = pickedProject.value!.title;
    pickedProject.notifyListeners();
    FocusScope.of(context).unfocus();
    panelProvider.changePanelStatus(newStatus: PanelStatus.hide);
  }

  final pickedUser = ValueNotifier<UserProfileModel?>(null);

  void pickUser({
    required UserProfileModel newUser,
    required BuildContext context,
  }) {
    pickedUser.value = newUser;
    userTextController.text = pickedUser.value!.username;
    pickedUser.notifyListeners();
    FocusScope.of(context).unfocus();
    panelProvider.changePanelStatus(newStatus: PanelStatus.hide);
  }

  
}
