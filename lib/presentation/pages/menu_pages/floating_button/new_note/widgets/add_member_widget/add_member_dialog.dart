import 'package:flutter/material.dart';
import 'package:todo2/database/database_scheme/storage_scheme.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/add_member_widget/member_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/services/supabase/constants.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class AddUserDialog extends StatelessWidget {
  AddUserDialog({Key? key}) : super(key: key);

  final userTextController = TextEditingController();

  // TODO remove dublication
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

    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      content: SizedBox(
        height: 400,
        width: 200,
        child: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 180,
                height: 35,
                child: TextField(
                  onChanged: (value) async => Future.delayed(
                      const Duration(milliseconds: 600), () => setState(() {})),
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
              Expanded(
                child: DisabledGlowWidget(
                  child: FutureBuilder<List<UserProfileModel>>(
                    initialData: const [],
                    future: fetchUsers(userName: userTextController.text),
                    builder: (context,
                        AsyncSnapshot<List<UserProfileModel>> snapshot) {
                      return (snapshot.hasError || !snapshot.hasData)
                          ? const Center(
                              child: CircularProgressIndicator.adaptive())
                          : ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data![index];
                              

                                return UserItemWidget(
                                  data: data,
                                  index: index,
                                  email: emails[index],
                                );
                              },
                            );
                    },
                  ),
                ),
              ),
              ConfirmButtonWidget(
                width: 150,
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
