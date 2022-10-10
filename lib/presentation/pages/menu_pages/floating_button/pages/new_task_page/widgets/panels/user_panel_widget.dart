import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/panel_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks_controller.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class UserPanelPickerWidget extends StatelessWidget {
  final BaseTasksController addEditTaskController;
  const UserPanelPickerWidget({
    Key? key,
    required this.addEditTaskController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserProfileModel>>(
      initialData: const [],
      future: addEditTaskController.taskMemberSearch(
        userName: addEditTaskController.memberTextController.text,
      ),
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
                      addEditTaskController.panelProvider
                          .changePanelStatus(newStatus: PanelStatus.hide);
                      addEditTaskController.pickUser(
                        newUser: data,
                        context: context,
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        data.avatarUrl,
                        headers: addEditTaskController.imageHeader,
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
