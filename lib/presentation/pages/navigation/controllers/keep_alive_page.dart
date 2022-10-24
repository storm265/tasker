import 'package:flutter/material.dart';

class KeepAlivePageWidget extends StatefulWidget {
  final Widget child;
  const KeepAlivePageWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  KeepAlivePageWidgetState createState() => KeepAlivePageWidgetState();
}

class KeepAlivePageWidgetState extends State<KeepAlivePageWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
