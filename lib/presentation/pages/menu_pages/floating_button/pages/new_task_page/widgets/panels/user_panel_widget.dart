import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class UserPanelPickerWidget extends StatelessWidget {
  UserPanelPickerWidget({Key? key}) : super(key: key);
  final taskController = AddTaskController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserProfileModel>>(
      initialData: const [],
      future: taskController.taskMemberSearch(
          nickname: taskController.userTextController.text),
      builder: (context, AsyncSnapshot<List<UserProfileModel>> snapshot) {
        log('data  : ${snapshot.data}');
        return (!snapshot.hasData || snapshot.data == null)
            ? Center(
                child: ProgressIndicatorWidget(
                  text: LocaleKeys.loaing.tr(),
                ),
              )
            : ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, i) {
                  final data = snapshot.data![i];

                  return ListTile(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      taskController.changePanelStatus(
                          newStatus: InputFieldStatus.hide);
                      taskController.pickUser(
                        newUser: data,
                        context: context,
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        data.avatarUrl,
                        headers: taskController.imageHeader,
                      ),
                    ),
                    title: Text(
                      data.username,
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    subtitle: Text(
                      data.email,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
