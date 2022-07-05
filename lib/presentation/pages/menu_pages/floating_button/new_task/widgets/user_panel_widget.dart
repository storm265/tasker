import 'package:flutter/material.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/services/supabase/constants.dart';

class UserPanelPickerWidget extends StatelessWidget {
  const UserPanelPickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return FutureBuilder<List<UserProfileModel>>(
                  initialData: const [],
                  future:   newTaskController.controllerUserProfile.fetchUsers(userName: newTaskController.forTextController.text),
                  builder: (context,
                      AsyncSnapshot<List<UserProfileModel>> snapshot) {
                    return (snapshot.hasError || !snapshot.hasData)
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data![index];
                              final avatar = SupabaseSource()
                                      .restApiClient
                                      .storage
                                      .from('avatar')
                                      .getPublicUrl(snapshot.data![0].avatarUrl)
                                      .data ??
                                  '';
                              return InkWell(
                                onTap: () {
                                  // TODO fix it using controller
                                  // selectedModel = data;
                                  // newTaskController.forTextController.text =
                                  //     selectedModel!.username;
                                  FocusScope.of(context).unfocus();
                                  newTaskController.changePanelStatus(
                                      newStatus: InputFieldStatus.hide);
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: NetworkImage(avatar)),
                                  title: Text(data.username),
                                  // TODO fix it
                                  //subtitle: Text(emailResponce[index]),
                                ),
                              );
                            },
                          );
                  },
                );
  }
}