import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/panel_decoration.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/tasks_text_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/dialogs/settings_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/user_data_widget.dart';

class ProfileWidget extends StatefulWidget {
  final int completedTasks;
  final int createdTask;
  final ProfileController profileController;
  const ProfileWidget({
    Key? key,
    required this.profileController,
    required this.completedTasks,
    required this.createdTask,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with SingleTickerProviderStateMixin {

      Future<void> fetchData()async{
         await widget.profileController
        .fetchProfileInfo(updateStateCallback: () => setState(() {}));

  
      }
  @override
  void initState() {
      widget.profileController.rotateSettingsIcon(ticker: this);
   fetchData();
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
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
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
                  turns: Tween(begin: 0.0, end: 1.0).animate(
                      widget.profileController.iconAnimationController),
                  child: const Icon(Icons.settings),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               UserDataWidget(
                    imageHeader: widget.profileController.imageHeader,
                    imageUrl: widget.profileController.imageUrl,
                    email: widget.profileController.email,
                    username: widget.profileController.username,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TasksTextWidget(
                      title: '${widget.createdTask}',
                      subtitle: 'Created Task',
                    ),
                    TasksTextWidget(
                      title: '${widget.completedTasks}',
                      subtitle: 'Completed Tasks',
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
