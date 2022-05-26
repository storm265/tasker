import 'package:flutter/material.dart';
import 'package:todo2/presentation/appbar_widget.dart';

class QuickPage extends StatelessWidget {
  const QuickPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Quick notes'),
      body: Center(
        child: Text('QuickPage'),
      ),
    );
  }
}
