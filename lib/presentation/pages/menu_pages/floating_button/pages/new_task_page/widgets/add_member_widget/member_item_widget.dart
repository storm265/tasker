import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';

class UserItemWidget extends StatefulWidget {
  final AddTaskController taskController;
  final int index;
  final UserProfileModel data;

  const UserItemWidget({
    Key? key,
    required this.data,
    required this.index,
    required this.taskController,
  }) : super(key: key);

  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  bool isSelected = false;
  final taskController = AddTaskController();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.data.avatarUrl,
            headers: taskController.imageHeader),
      ),
      title: Text(widget.data.username),
      subtitle: Text(
        widget.data.email,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: InkWell(
        child: Icon(
          Icons.done,
          color: isSelected ? Colors.green : Colors.grey,
        ),
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            if (isSelected) {
              taskController.addMember(userModel: widget.data);
            } else {
              taskController.removeMember(model: widget.data);
            }
          });
        },
      ),
    );
  }
}
