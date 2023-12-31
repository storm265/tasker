import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarItemWidget extends StatelessWidget {
  const NavBarItemWidget({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String? icon;

  final Color? iconColor;

  final String label;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 62,
            height: 62,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                SvgPicture.asset(
                  'assets/images/nav_bar_icons/$icon.svg',
                  // ignore: deprecated_member_use
                  color: iconColor,
                ),
                FittedBox(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
