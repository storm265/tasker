import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/nav_bar_widget.dart';

class NavBarItemWidget extends StatelessWidget {
  final int pageIndex;
  final String label;
  final String icon;
  final VoidCallback onTapCallback;

  const NavBarItemWidget({
    Key? key,
    required this.icon,
    required this.label,
    required this.pageIndex,
    required this.onTapCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: NavBarItem(
        label: label,
        icon: icon,
        iconColor: pageIndex == 0 ? Colors.white : Colors.grey,
      ),
    );
  }
}
