import 'package:flutter/material.dart';

class DynamicPhycicsSingleChildScrollView extends StatelessWidget {
  final Widget child;
  final bool? isActivesScrolling;
  final ScrollController scrollController;
  const DynamicPhycicsSingleChildScrollView({
    Key? key,
    required this.child,
    this.isActivesScrolling,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: isActivesScrolling == true
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      child: child,
    );
  }
}
