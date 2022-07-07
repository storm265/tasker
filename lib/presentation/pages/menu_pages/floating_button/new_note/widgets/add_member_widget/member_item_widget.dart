import 'package:flutter/material.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/controller_inherited.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/image_widget.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class UserItemWidget extends StatefulWidget {
  final int index;
  final UserProfileModel data;
  const UserItemWidget({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final newTaskController =
        InheritedNewTaskController.of(context).addTaskController;
    return ListTile(
      leading: CachedAvatarWidget(
        image: widget.data.avatarUrl,
      ),
      title: Text(widget.data.username),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            isSelected = !isSelected;
            if (isSelected) {
              newTaskController.addMember(chipTitle: widget.data);
            } else {
              newTaskController.removeMember(index: widget.index);
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
