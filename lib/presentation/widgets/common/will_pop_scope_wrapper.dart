import 'package:flutter/cupertino.dart';

class WillPopWrapper extends StatelessWidget {
  final Widget child;
  const WillPopWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () async => false,
    );
  }
}
