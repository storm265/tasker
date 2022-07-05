import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_user_data_source.dart';
import 'package:todo2/database/data_source/user_profile_data_source.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/add_user_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/description_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/for_in_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/fake_nav_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/widgets/pick_time_field_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/circle_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';
import 'package:todo2/services/supabase/constants.dart';

enum InputFieldStatus {
  showUserPanel,
  showProjectPanel,
  hide,
}

final _forTextController = TextEditingController(text: 'Assignee');
final _inTextController = TextEditingController(text: 'Project');

class SelectUserWidget extends StatelessWidget {
  UserProfileModel? selectedModel;
  ProjectModel? selectedProject;
  Future<List<UserProfileModel>> fetchUsers({required String userName}) async {
    try {
      final response = await SupabaseSource()
          .restApiClient
          .from('user_profile')
          .select('*')
          .ilike(
            'username',
            '%$userName%',
          )
          .execute();
      return (response.data as List<dynamic>)
          .map((json) => UserProfileModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in ------ fetchProject() ------ $e');
      rethrow;
    }
  }

  Future<List<ProjectModel>> fetchProjects({required String title}) async {
    try {
      final response = await SupabaseSource()
          .restApiClient
          .from('projects')
          .select('*')
          .ilike(
            'title',
            '%$title%',
          )
          .execute();
      log(response.data.toString());
      return (response.data as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in ------ fetchProjects() ------ $e');
      rethrow;
    }
  }

  SelectUserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFFF4F4F4),
        ),
        height: 500,
        width: 365,
        child: ValueListenableBuilder<InputFieldStatus>(
          valueListenable: newTaskController.panelStatus,
          builder: (context, status, _) {
            switch (status) {
              case InputFieldStatus.hide:
                return const SizedBox();
              case InputFieldStatus.showUserPanel:
                return FutureBuilder<List<UserProfileModel>>(
                  initialData: const [],
                  future: fetchUsers(userName: _forTextController.text),
                  builder: (context,
                      AsyncSnapshot<List<UserProfileModel>> snapshot) {
                    return (snapshot.hasError || !snapshot.hasData)
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final avatar = SupabaseSource()
                                      .restApiClient
                                      .storage
                                      .from('avatar')
                                      .getPublicUrl(snapshot.data![0].avatarUrl)
                                      .data ??
                                  '';
                              return InkWell(
                                onTap: () {
                                  selectedModel = snapshot.data![index];
                                  _forTextController.text =
                                      selectedModel!.username;
                                  FocusScope.of(context).unfocus();
                                  newTaskController.changePanelStatus(
                                      newStatus: InputFieldStatus.hide);
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: NetworkImage(avatar)),
                                  title: Text(snapshot.data![index].username),
                                  subtitle: Text('Stephenchow@company.com'),
                                ),
                              );
                            },
                          );
                  },
                );
              case InputFieldStatus.showProjectPanel:
                return FutureBuilder<List<ProjectModel>>(
                  initialData: const [],
                  future: fetchProjects(title: _inTextController.text),
                  builder:
                      (context, AsyncSnapshot<List<ProjectModel>> snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            selectedProject = data;
                            _inTextController.text = selectedProject!.title;
   
                            FocusScope.of(context).unfocus();
                            newTaskController.changePanelStatus(
                                newStatus: InputFieldStatus.hide);
                          },
                          child: ListTile(
                            leading: DoubleCircleWidget(
                                color: data.color, isUsePositioned: false,),
                            title: Text(data.title),
                            subtitle: Text(data.createdAt),
                          ),
                        );
                      },
                    );
                  },
                );
            }
          },
        ));
  }
}

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  void dispose() {
    _forTextController.dispose();
    _inTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        title: 'New Task',
        showLeadingButton: true,
        shouldUsePopMethod: true,
        child: Stack(
          children: [
            redAppBar,
            fakeNavBar,
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                newTaskController.changePanelStatus(
                    newStatus: InputFieldStatus.hide);
              },
              child: WhiteBoxWidget(
                height: 570,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          EnterUserWidget(
                            isForFieldActive: true,
                            onChanged: (value) async => await Future.delayed(
                                const Duration(milliseconds: 500),
                                () => setState(() {})),
                            titleController: _forTextController,
                            text: 'For',
                          ),
                          EnterUserWidget(
                            isForFieldActive: false,
                            onChanged: (value) async => await Future.delayed(
                                const Duration(milliseconds: 500),
                                () => setState(() {})),
                            titleController: _inTextController,
                            text: 'In',
                          )
                        ],
                      ),
                    ),
                    ValueListenableBuilder<InputFieldStatus>(
                        valueListenable: newTaskController.panelStatus,
                        builder: (_, value, __) {
                          return (value != InputFieldStatus.hide)
                              ? SelectUserWidget()
                              : Column(
                                  children: [
                                    const TitleWidget(),
                                    const DescriptionFieldWidget(),
                                    const PickTimeFieldWidget(),
                                    const AddUserWidget(),
                                    ConfirmButtonWidget(
                                      onPressed: () =>
                                          NavigationService.navigateTo(
                                        context,
                                        Pages.taskList,
                                      ),
                                      title: 'Add Task',
                                    ),
                                  ],
                                );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
