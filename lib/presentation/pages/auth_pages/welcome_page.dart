import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';
import 'package:todo2/presentation/widgets/welcome_page/widgets/asseter_widget.dart';
import 'package:todo2/presentation/widgets/welcome_page/widgets/background_wave_widget.dart';
import 'package:todo2/presentation/widgets/welcome_page/widgets/dots_pager_widget.dart';
import 'package:todo2/presentation/widgets/welcome_page/widgets/foreground_wave_widget.dart';
import 'package:todo2/presentation/widgets/welcome_page/widgets/get_started_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            AsseterWidget(
                onChange: (index) => setState(() => _pageIndex = index)),
            DotsPagerWidget(pageIndex: _pageIndex),
            ForegroundWaveWidget(pageIndex: _pageIndex),
            BackgroundWaveWidget(pageIndex: _pageIndex),
            const GetStartedButtonWidget()
          ],
        ),
      ),
    );
  }
}
