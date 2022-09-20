import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';

import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class UserPanelPickerWidget extends StatelessWidget {
  UserPanelPickerWidget({Key? key}) : super(key: key);

// TODO remove dublication
  List<String> emails = [];
  List<UserProfileModel> users = [];

  // Future<List<UserProfileModel>> fetchUsers({required String userName}) async {
  //   emails = await UserRepositoryImpl().fetchEmail();
  //   users =
  //       await UserProfileRepositoryImpl().fetchUserWhere(userName: userName);

  //   return users;
  // }

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return FutureBuilder<List<UserProfileModel>>(
      initialData: const [],
      //future: fetchUsers(userName: newTaskController.userTextController.text),
      builder: (context, AsyncSnapshot<List<UserProfileModel>> snapshot) {
        return (snapshot.hasError || !snapshot.hasData)
            ? const Center(
                child: ProgressIndicatorWidget(),
              )
            : ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  // final avatar = NetworkSource()
                  //
                  //         .storage
                  //         .from('avatar')
                  //         .getPublicUrl(snapshot.data![index].avatarUrl)
                  //         .data ??
                  //     '';
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
                      // leading:
                      //     CircleAvatar(backgroundImage: NetworkImage(avatar)),
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
