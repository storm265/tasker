import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/welcome/widgets/asseter_widget.dart';
import 'package:todo2/presentation/pages/auth/welcome/widgets/background_wave_widget.dart';
import 'package:todo2/presentation/pages/auth/welcome/widgets/dots_pager_widget.dart';
import 'package:todo2/presentation/pages/auth/welcome/widgets/foreground_wave_widget.dart';
import 'package:todo2/presentation/pages/auth/welcome/widgets/get_started_button.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AppbarWrapWidget(
      showAppBar: true,
      isRedAppBar: false,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          ForegroundWaveWidget(pageIndex: _pageIndex),
          BackgroundWaveWidget(pageIndex: _pageIndex),
          AsseterWidget(
            onChange: (index) => setState(() => _pageIndex = index),
          ),
          DotsPagerWidget(pageIndex: _pageIndex),
          GetStartedButton(pageIndex: _pageIndex),
        ],
      ),
    );
  }
}
