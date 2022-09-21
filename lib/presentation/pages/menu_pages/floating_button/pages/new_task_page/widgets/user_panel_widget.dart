import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class UserPanelPickerWidget extends StatelessWidget {
  const UserPanelPickerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return FutureBuilder<List<UserProfileModel>>(
      initialData: const [],
      future: newTaskController.taskMemberSearch(
          nickname: newTaskController.userTextController.text),
      builder: (context, AsyncSnapshot<List<UserProfileModel>> snapshot) {
        log('data len : ${snapshot.data!.length}');
        return (snapshot.hasError || !snapshot.hasData)
            ? const Center(
                child: ProgressIndicatorWidget(text: 'Loading...'),
              )
            : ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, i) {
                  final data = snapshot.data![i];

                  return ListTile(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      newTaskController.changePanelStatus(
                          newStatus: InputFieldStatus.hide);
                      newTaskController.pickUser(
                        newUser: data,
                        context: context,
                      );
                    },
                    leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                            'https://image.winudf.com/v2/image1/Y29tLmFwcDNkd2FsbHBhcGVyaGQubW91bnRhaW53YWxscGFwZXJfc2NyZWVuXzVfMTU2NzAzMDU0MF8wNjk/screen-5.jpg?fakeurl=1&type=.jpg')),
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
