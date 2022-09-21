import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/widgets/add_member_widget/member_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';

import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class AddUserDialog extends StatelessWidget {
  AddUserDialog({Key? key}) : super(key: key);

  final userTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      content: SizedBox(
        height: 400,
        width: 200,
        child: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: TextField(
                    onChanged: (value) async => Future.delayed(
                        const Duration(milliseconds: 600),
                        () => setState(() {})),
                    controller: userTextController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => newTaskController.clearMemberList(),
                        icon: const Icon(
                          Icons.delete,
                          color: Palette.red,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Palette.red,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Palette.red,
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Palette.red,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: DisabledGlowWidget(
                  child: FutureBuilder<List<UserProfileModel>>(
                    initialData: const [],
                    future: newTaskController.taskMemberSearch(
                        nickname: userTextController.text),
                    builder: (context,
                        AsyncSnapshot<List<UserProfileModel>> snapshot) {
                      return (snapshot.hasError || !snapshot.hasData)
                          ? const Center(
                              child: ProgressIndicatorWidget(),
                            )
                          : ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, i) {
                                return UserItemWidget(
                                  data: snapshot.data![i],
                                  index: i,
                                );
                              },
                            );
                    },
                  ),
                ),
              ),
              ConfirmButtonWidget(
                width: 180,
                onPressed: () => Navigator.pop(context),
                title: 'Done',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
