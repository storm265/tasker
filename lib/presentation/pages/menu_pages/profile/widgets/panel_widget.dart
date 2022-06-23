
import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/controller/auth_controller.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/image_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/panel_widgets/tasks_text_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/profile/widgets/settings_dialog.dart';
import 'package:todo2/services/supabase/constants.dart';

class PanelWidget extends StatefulWidget {
  const PanelWidget({Key? key}) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  final _signUpController = SignUpController();
  final _userProfileRepository = UserProfileRepositoryImpl();
  late String _userName = '', _image = '';
  bool isClicked = true;

  @override
  void dispose() {
    _signUpController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getUserData().then((_) => setState(() {}));
    super.initState();
  }

  Future<void> getUserData() async {
    _image = await _userProfileRepository.fetchAvatar();
    _userName = await _userProfileRepository.fetchUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: Color(0xFFE0E0E0), blurRadius: 10),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        width: 350,
        height: 200,
        child: Stack(
          children: [
            Positioned(
              left: 290,
              child: IconButton(
                onPressed: () => showSettingsDialog(context),
                icon: const Icon(Icons.settings),
              ),
            ),
            Positioned(
              top: 40,
              child: SizedBox(
                width: 300,
                height: 70,
                child: ListTile(
                  leading: CachedAvatarWidget(image: _image),
                  title: Text(
                    _userName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  subtitle: Text(
                    '${SupabaseSource().restApiClient.auth.currentUser!.email}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const TasksTextWidget(
              left: 10,
              top: 120,
              title: '120',
              subtitle: 'Create Tasks',
            ),
            const TasksTextWidget(
              left: 200,
              top: 120,
              title: '999',
              subtitle: 'Completed Tasks',
            ),
          ],
        ),
      ),
    );
  }
}
