import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/sign_in_up/widgets/signup_to_continue_widget.dart';
import 'package:todo2/presentation/pages/auth/widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class PasswordChangedPage extends StatefulWidget {
  const PasswordChangedPage({Key? key}) : super(key: key);

  @override
  State<PasswordChangedPage> createState() => _PasswordChangedPageState();
}

class _PasswordChangedPageState extends State<PasswordChangedPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4),
        () => NavigationService.navigateTo(context, Pages.home));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppbarWrapperWidget(
      showAppBar: true,
      isRedAppBar: false,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 160,
            left: 120,
            child: Image.asset('assets/changed_password.png'),
          ),
          const TitleTextWidget(
            text: 'Succesful!',
            left: 135,
          ),
          const SubTitleWidget(
            text:
                'You have succesfully change password.\nPlease use your new passwords when logging in.',
            left: 50,
          )
        ],
      ),
    );
  }
}
