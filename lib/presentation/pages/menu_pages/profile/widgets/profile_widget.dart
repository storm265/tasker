import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/panel_decoration.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/tasks_text_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/dialogs/settings_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/user_data_widget.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with SingleTickerProviderStateMixin {
  final _profileController = ProfileController();

  @override
  void initState() {
    _profileController.rotateSettingsIcon(ticker: this);
    _profileController.fetchProfileInfo(
        context: context, updateStateCallback: () => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _profileController.iconAnimationController.dispose();
    _profileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: panelDecoration,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            left: 310,
            child: IconButton(
              onPressed: () => showSettingsDialog(context),
              icon: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0)
                    .animate(_profileController.iconAnimationController),
                child: const Icon(
                  Icons.settings,
                ),
              ),
            ),
          ),
          UserDataWidget(
            avatarImage: _profileController.image,
            email: '${_profileController.supabase!.email}',
            nickname: _profileController.userName,
          ),
          const TasksTextWidget(
            left: 30,
            title: '120',
            subtitle: 'Create Tasks',
          ),
          const TasksTextWidget(
            left: 180,
            title: '999',
            subtitle: 'Completed Tasks',
          ),
        ],
      ),
    );
  }
}
