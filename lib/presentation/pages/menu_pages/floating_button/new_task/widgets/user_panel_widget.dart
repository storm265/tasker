import 'package:flutter/material.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/services/supabase/constants.dart';

class UserPanelPickerWidget extends StatelessWidget {
  UserPanelPickerWidget({Key? key}) : super(key: key);

  List<String> emails = [];
  List<UserProfileModel> users = [];

  Future<List<UserProfileModel>> fetchUsers({required String userName}) async {
    emails = await UserRepositoryImpl().fetchEmail();
    users = await UserProfileRepositoryImpl().fetchUsers(userName: userName);

    return users;
  }

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return FutureBuilder<List<UserProfileModel>>(
      initialData: const [],
      future: fetchUsers(userName: newTaskController.userTextController.text),
      builder: (context, AsyncSnapshot<List<UserProfileModel>> snapshot) {
        return (snapshot.hasError || !snapshot.hasData)
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  final avatar = SupabaseSource()
                          .restApiClient
                          .storage
                          .from('avatar')
                          .getPublicUrl(snapshot.data![index].avatarUrl)
                          .data ??
                      '';
                  return InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      newTaskController.changePanelStatus(
                          newStatus: InputFieldStatus.hide);
                    },
                    child: ListTile(
                      onTap: () => newTaskController.pickUser(
                        newUser: data,
                        context: context,
                      ),
                      leading:
                          CircleAvatar(backgroundImage: NetworkImage(avatar)),
                      title: Text(data.username),
                      subtitle: Text(emails[index]),
                    ),
                  );
                },
              );
      },
    );
  }
}
