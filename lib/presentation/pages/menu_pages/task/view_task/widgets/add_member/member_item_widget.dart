import 'package:flutter/material.dart';
import 'package:todo2/domain/model/profile_models/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';

class MemberItemWidget extends StatefulWidget {
  final ViewTaskController viewTaskController;
  final int index;
  final UserProfileModel userModel;

  const MemberItemWidget({
    Key? key,
    required this.userModel,
    required this.index,
    required this.viewTaskController,
  }) : super(key: key);

  @override
  State<MemberItemWidget> createState() => _MemberItemWidgetState();
}

class _MemberItemWidgetState extends State<MemberItemWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(
          widget.userModel.avatarUrl,
          headers: widget.viewTaskController.imageHeader,
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
              widget.viewTaskController.memberProvider
                  .addMember(userModel: widget.userModel);
      
            } else {
              widget.viewTaskController.memberProvider
                  .removeMember(model: widget.userModel);
            }
          });
        },
      ),
    );
  }
}
