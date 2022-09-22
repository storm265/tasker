import 'package:flutter/material.dart';

class FakeNavBarWidget extends StatelessWidget {

  const FakeNavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 80,
        color: const Color(0xFF292E4E),
      ),
    );
  }
}
