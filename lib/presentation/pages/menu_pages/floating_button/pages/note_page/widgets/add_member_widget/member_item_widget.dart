import 'package:flutter/material.dart';
import 'package:todo2/database/model/profile_models/users_profile_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/controller_inherited.dart';

const url =
    'https://image.winudf.com/v2/image1/Y29tLmFwcDNkd2FsbHBhcGVyaGQubW91bnRhaW53YWxscGFwZXJfc2NyZWVuXzVfMTU2NzAzMDU0MF8wNjk/screen-5.jpg?fakeurl=1&type=.jpg';

class UserItemWidget extends StatefulWidget {
  final int index;
  final UserProfileModel data;

  const UserItemWidget({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

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
      leading: CircleAvatar(
        // backgroundImage: NetworkImage(widget.data.avatarUrl),
        backgroundImage: NetworkImage(url),
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
              newTaskController.addMember(chipTitle: widget.data);
            } else {
              newTaskController.removeMember(index: widget.index);
            }
          });
        },
      ),
    );
  }
}
