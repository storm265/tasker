import 'package:flutter/material.dart';

final List<BottomNavigationBarItem> navBarItems = [];

class NavBarItem extends StatelessWidget {
  final String icon;
  final Color iconColor;
  const NavBarItem({Key? key, required this.icon, required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/nav_bar_icons/$icon.png', color: iconColor);
  }
}
