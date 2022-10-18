import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/user_data_widget.dart';
import 'package:todo2/presentation/providers/file_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/controller/profile_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/panel_decoration.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/tasks_text_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/dialogs/settings_dialog.dart';
import 'package:todo2/presentation/widgets/common/add_photo_widget.dart';
import 'package:todo2/utils/assets_path.dart';

  const   _avatarmaxSize = 64;
  
class ProfileWidget extends StatefulWidget {
  final int completedTasks;
  final int createdTask;
  final ProfileController profileController;
  final FileProvider fileProvider;
  const ProfileWidget({
    Key? key,
    required this.profileController,
    required this.completedTasks,
    required this.createdTask,
    required this.fileProvider,
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
                  callback: () => setState(() {
                    log('set state');
                  }),
                  context: context,
                  profileController: widget.profileController,
                  imageController: widget.fileProvider,
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
                      SizedBox(
                        width: double.parse(_avatarmaxSize.toString()),
                        height: double.parse(_avatarmaxSize.toString()),
                        child: ValueListenableBuilder<String>(
                          valueListenable: widget.profileController.imageUrl,
                          builder: (__, url, _) => url.isEmpty
                              ? const CircleAvatar(
                                  backgroundColor: Color(0xffC4C4C4),
                                  child: addPhotoWidget,
                                )
                              : CachedNetworkImage(
                                  imageUrl: url,
                                  httpHeaders:
                                      widget.profileController.imageHeader,
                                  imageBuilder: (_, imageProvider) {
                                    return CircleAvatar(
                                        backgroundImage: imageProvider);
                                  },
                                  placeholder: ((_, url) => SizedBox(
                                        width: double.parse(_avatarmaxSize.toString()),
                                        height:
                                            double.parse(_avatarmaxSize.toString()),
                                        child: const CircleAvatar(
                                          backgroundColor: Color(0xffC4C4C4),
                                          child: addPhotoWidget,
                                        ),
                                      )),
                                  errorWidget: (_, url, error) {
                                    log('errorWidget error $error');
                                    return SizedBox(
                                      width: double.parse(_avatarmaxSize.toString()),
                                      height: double.parse(_avatarmaxSize.toString()),
                                      child: const CircleAvatar(
                                        backgroundColor: Color(0xffC4C4C4),
                                        child: addPhotoWidget,
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      UserDataWidget(
                        profileController: widget.profileController,
                      )
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
