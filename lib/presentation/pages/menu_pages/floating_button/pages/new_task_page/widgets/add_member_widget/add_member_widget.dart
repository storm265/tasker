import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/domain/model/profile_models/users_profile_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/add_member_widget/add_member_dialog.dart';

class AddMemberWidget extends StatefulWidget {
  final AddEditTaskController addEditTaskController;
  const AddMemberWidget({
    Key? key,
    required this.addEditTaskController,
  }) : super(key: key);

  @override
  State<AddMemberWidget> createState() => _AddMemberWidgetState();
}

class _AddMemberWidgetState extends State<AddMemberWidget> {
  late final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<UserProfileModel>>(
      valueListenable: widget.addEditTaskController.memberProvider.taskMembers,
      builder: (_, users, __) => (users.isEmpty)
          ? Padding(
              padding: const EdgeInsets.only(
                left: 25,
                bottom: 20,
                top: 20,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      LocaleKeys.add_member.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SizedBox(
                          width: 90,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0xFFF4F4F4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              LocaleKeys.anyone.tr(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      RawMaterialButton(
                        elevation: 0,
                        onPressed: () async => await showDialog(
                          context: context,
                          builder: (_) => AddUserDialog(
                            taskController: widget.addEditTaskController,
                          ),
                        ),
                        fillColor: Colors.grey.withOpacity(0.5),
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
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
                itemBuilder: (_, i) {
                  final userList = users.toList();
                  return Row(
                    children: [
                      InkWell(
                        onLongPress: () {
                          widget.addEditTaskController.memberProvider
                              .removeMember(
                            model: userList[i],
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Tooltip(
                            message: userList[i].username,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 17,
                              backgroundImage: NetworkImage(
                                userList[i].avatarUrl,
                                headers:
                                    widget.addEditTaskController.imageHeader,
                              ),
                            ),
                          ),
                        ),
                      ),
                      (i == users.length - 1)
                          ? RawMaterialButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (_) => AddUserDialog(
                                        taskController:
                                            widget.addEditTaskController,
                                      )),
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
