import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/providers/file_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/cached_avatar_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/panel_decoration.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/tasks_text_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/dialogs/settings_dialog.dart';
import 'package:todo2/utils/assets_path.dart';

class ProfileWidget extends StatefulWidget {
  final int completedTasks;
  final int createdTask;
  final ProfileController profileController;
  final FileProvider imageController;
  const ProfileWidget({
    Key? key,
    required this.profileController,
    required this.completedTasks,
    required this.createdTask,
    required this.imageController,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with SingleTickerProviderStateMixin {
  Future<void> fetchData() async {
    await widget.profileController.fetchProfileInfo();
  }

  @override
  void initState() {
    widget.profileController.rotateSettingsIcon(ticker: this);
    fetchData().then((_) => setState(() {}));
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
                splashRadius: 20,
                onPressed: () => showSettingsDialog(
                  callback: () => setState(() {}),
                  context: context,
                  profileController: widget.profileController,
                  imageController: widget.imageController,
                ),
                icon: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(
                      widget.profileController.iconAnimationController),
                  child: SvgPicture.asset(AssetsPath.settingsIconPath),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 30),
                      CachedAvatarWidget(
                        profileController: widget.profileController,
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.profileController.email,
                              style: const TextStyle(
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w200,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              widget.profileController.username,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TasksTextWidget(
                      title: '${widget.createdTask}',
                      subtitle: LocaleKeys.created_tasks.tr(),
                    ),
                    TasksTextWidget(
                      title: '${widget.completedTasks}',
                      subtitle: LocaleKeys.completed_tasks.tr(),
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
