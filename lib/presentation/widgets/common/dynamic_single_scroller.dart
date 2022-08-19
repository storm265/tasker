import 'package:flutter/material.dart';

class DynamicPhycicsSingleChildScrollView extends StatelessWidget {
  final Widget child;
  final bool? isDisabledScroll;
  const DynamicPhycicsSingleChildScrollView({
    Key? key,
    required this.child,
    this.isDisabledScroll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: isDisabledScroll == true
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: child,
      ),
    );
  }
}
