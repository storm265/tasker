import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/services/supabase/constants.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class AddUserWidget extends StatefulWidget {
  const AddUserWidget({Key? key}) : super(key: key);

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  late final AddTaskController _addTaskController;
  late final _scrollController = ScrollController();
  @override
  void didChangeDependencies() {
    _addTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (_addTaskController.selectedUsers.value.isEmpty)
        ? Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 20, top: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      primary: const Color(0xFFF4F4F4),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Anyone',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                RawMaterialButton(
                  elevation: 0,
                  onPressed: () => showDialog(
                      context: context, builder: (_) => AddUserDialog()),
                  fillColor: Colors.grey.withOpacity(0.5),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        : SizedBox(
            width: 300,
            height: 100,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _addTaskController.selectedUsers.value.length,
              itemBuilder: (context, index) {
                return ValueListenableBuilder<List<UserProfileModel>>(
                  valueListenable: _addTaskController.selectedUsers,
                  builder: (_, users, __) => Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Text(users[index].username),
                        // child: CircleAvatar(
                        //   radius: 17,
                        //   backgroundColor: Colors.red,
                        // ),
                      ),
                      (index ==
                              _addTaskController.selectedUsers.value.length - 1)
                          ? RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  // TODO refactor push to controller
                                  // addTaskController.usersList.value
                                  //     .add(UserProfileModel(
                                  //   username: 'User $index',
                                  //   avatarUrl: 'avatarUrl',
                                  //   createdAt: 'createdAt',
                                  // ));
                                  // newTaskConroller.chipTitles.value.add(
                                  //     'element: ${newTaskConroller.chipTitles.value.length + 1}');
                                  _scrollController.jumpTo(_scrollController
                                          .position.maxScrollExtent +
                                      20);
                                });
                              },
                              fillColor: Colors.grey.withOpacity(0.5),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                );
              },
            ),
          );
  }
}

class AddUserDialog extends StatelessWidget {
  AddUserDialog({Key? key}) : super(key: key);

  final userTextController = TextEditingController();

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
                    prefixIcon: Icon(Icons.search),
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
                    future: newTaskController.controllerUserProfile
                        .fetchUsers(userName: userTextController.text),
                    builder: (context,
                        AsyncSnapshot<List<UserProfileModel>> snapshot) {
                      return (snapshot.hasError || !snapshot.hasData)
                          ? const Center(
                              child: CircularProgressIndicator.adaptive())
                          : ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data![index];
                                // final avatar = SupabaseSource()
                                //         .restApiClient
                                //         .storage
                                //         .from('avatar')
                                //         .getPublicUrl(
                                //             snapshot.data![0].avatarUrl)
                                //         .data ??
                                //     '';
                                return UserItemWidget(data: data);
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

bool isSelected = false;

class UserItemWidget extends StatefulWidget {
  UserProfileModel data;
  UserItemWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return ListTile(
      // leading: CircleAvatar(
      //     backgroundImage: NetworkImage(avatar)),
      title: Text(widget.data.username),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            isSelected = !isSelected;
            if (isSelected) {
              newTaskController.addUser(widget.data);
              print(newTaskController.selectedUsers.value);
              //  newTaskController.forTextController.text =
              //     selectedModel!.username;
              // newTaskController
              //     .selectedUser.value = data;
              // newTaskController
              //     .selectedUsers.value
              //     .add(newTaskController
              //         .selectedUser.value);
              // print(newTaskController
              //     .selectedUsers);
              // TODO fix it using controller
              // selectedModel = data;

            }
          });
        },
        icon: const Icon(
          Icons.done,
        ),
        color: isSelected ? Palette.red : Colors.grey,
      ),
    );
  }
}
