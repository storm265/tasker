import 'package:flutter/material.dart';
import 'package:todo2/presentation/welcome_page/widgets/asseter_widget.dart';
import 'package:todo2/presentation/welcome_page/widgets/background_wave_widget.dart';
import 'package:todo2/presentation/welcome_page/widgets/dots_pager_widget.dart';
import 'package:todo2/presentation/welcome_page/widgets/foreground_wave_widget.dart';
import 'package:todo2/presentation/welcome_page/widgets/get_started_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: [
      AsseterWidget(
          size: _size, onChange: (index) => setState(() => _pageIndex = index)),
      DotsPagerWidget(pageIndex: _pageIndex, size: _size),
      ForegroundWaveWidget(pageIndex: _pageIndex, width: _size.width),
      BackgroundWaveWidget(pageIndex: _pageIndex, width: _size.width),
      GetStartedButtonWidget(width: _size.width)
    ]));
  }
}
