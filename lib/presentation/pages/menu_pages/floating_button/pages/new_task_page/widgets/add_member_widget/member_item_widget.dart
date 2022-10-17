import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/add_task_controller.dart';

class UserItemWidget extends StatefulWidget {
  final AddEditTaskController addEditTaskController;
  final int index;
  final UserProfileModel userModel;

  const UserItemWidget({
    Key? key,
    required this.userModel,
    required this.index,
    required this.addEditTaskController,
  }) : super(key: key);

  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(
          widget.userModel.avatarUrl,
          headers: widget.addEditTaskController.imageHeader,
        ),
      ),
      title: Text(widget.userModel.username),
      subtitle: Text(
        widget.userModel.email,
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
              widget.addEditTaskController.memberProvider
                  .addMember(userModel: widget.userModel);
            } else {
              widget.addEditTaskController.memberProvider
                  .removeMember(model: widget.userModel);
            }
          });
        },
      ),
    );
  }
}
