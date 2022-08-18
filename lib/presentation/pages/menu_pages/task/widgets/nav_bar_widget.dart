import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  final String? icon;
  final Color? iconColor;
  final String label;
  const NavBarItem(
      {Key? key,
      required this.icon,
      required this.iconColor,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 55,
        height: 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            Image.asset(
              'assets/nav_bar_icons/$icon.png',
              color: iconColor,
            ),
            Text(
              label,
              style: TextStyle(
                color: iconColor,
                fontSize: 12,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      ),
    );
  }
}
