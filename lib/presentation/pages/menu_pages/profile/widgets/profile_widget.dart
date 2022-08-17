import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/panel_decoration.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/tasks_text_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/dialogs/settings_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/user_data_widget.dart';

class ProfileWidget extends StatefulWidget {
  final ProfileController profileController;
  const ProfileWidget({Key? key, required this.profileController})
      : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    widget.profileController.rotateSettingsIcon(ticker: this);
    widget.profileController
        .fetchProfileInfo(updateStateCallback: () => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    widget.profileController.iconAnimationController.dispose();
    widget.profileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: panelDecoration,
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => showSettingsDialog(
                context: context,
                profileController: widget.profileController,
              ),
              icon: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0)
                    .animate(widget.profileController.iconAnimationController),
                child: const Icon(Icons.settings),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UserDataWidget(
                avatarImage: widget.profileController.image,
                email: widget.profileController.email,
                username: widget.profileController.username,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  TasksTextWidget(
                    title: '120',
                    subtitle: 'Created Task',
                  ),
                  TasksTextWidget(
                    title: '999',
                    subtitle: 'Completed Tasks',
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
