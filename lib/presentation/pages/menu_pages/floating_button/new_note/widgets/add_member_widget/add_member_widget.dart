import 'package:flutter/material.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/add_member_widget/add_member_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';


class AddUserWidget extends StatefulWidget {
  const AddUserWidget({Key? key}) : super(key: key);

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  late final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return ValueListenableBuilder<List<UserProfileModel>>(
      valueListenable: addTaskController.taskMembers,
      builder: (_, users, __) => (users.isEmpty)
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
                itemCount: users.length,
                itemBuilder: (context, index) {
                  // final avatar = NetworkSource()
                  //         .networkApiClient
                  //         .storage
                  //         .from(StorageScheme.avatar)
                  //         .getPublicUrl(users[index].avatarUrl)
                  //         .data ??
                  //     '';
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.red,
                         // backgroundImage: NetworkImage(avatar),
                          // child: Text(users[index].username),
                        ),
                      ),
                      (index == users.length - 1)
                          ? RawMaterialButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (_) => AddUserDialog()),
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
            ),
    );
  }
}
