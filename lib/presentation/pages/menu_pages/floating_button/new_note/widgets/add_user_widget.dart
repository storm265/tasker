import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';

class AddUserWidget extends StatefulWidget {
  const AddUserWidget({Key? key}) : super(key: key);

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final addTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return (addTaskController.usersList.value.isEmpty)
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
                  onPressed: () {
                    showUsersDialog(context);
                    // setState(() => newTaskConroller.chipTitles.value.add(
                    //     'element: ${newTaskConroller.chipTitles.value.length + 1}'));
                  },
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
              itemCount: addTaskController.usersList.value.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.red,
                      ),
                    ),
                    (index == addTaskController.usersList.value.length - 1)
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
                                _scrollController.jumpTo(
                                    _scrollController.position.maxScrollExtent +
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
                );
              },
            ),
          );
  }
}

Future<void> showUsersDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        content: SizedBox(
          height: 400,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(
              //   child: DisabledGlowWidget(
              //     child: ValueListenableBuilder<Map>(
              //       valueListenable: _addUserController.users,
              //       builder: (context, users, _) => ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: 12,
              //         itemBuilder: (context, index) =>
              //             UserListWidget(index: index),
              //       ),
              //     ),
              //   ),
              // ),
              ConfirmButtonWidget(
                width: 150,
                onPressed: () => Navigator.pop(context),
                title: 'Done',
              ),
            ],
          ),
        ),
      );
    },
  );
}

class AddUserController extends ChangeNotifier {
  final users = ValueNotifier([
    //UserProfileModel(username: 'user1', avatarUrl: 'url', createdAt: 'now')
  ]);
}

final _addUserController = AddUserController();

class UserListWidget extends StatefulWidget {
  int index;
  UserListWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Alex Punani'),
      subtitle: const Text('peter4533@mail.ru'),
      leading: const CircleAvatar(
        radius: 20,
      ),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            isSelected = !isSelected;
            // _addUserController.changeUser(
            //     _addUserController.users.value.keys.toList()[widget.index],
            //     isSelected);
          });
          log(_addUserController.users.value.toString());
        },
        icon: const Icon(Icons.done),
        color: isSelected ? Colors.green : Colors.grey,
      ),
    );
  }
}
