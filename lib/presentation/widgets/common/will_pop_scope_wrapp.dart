import 'package:flutter/cupertino.dart';

class WillPopWrap extends StatelessWidget {
  final Widget child;
  const WillPopWrap({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () async => false,
    );
  }
}
