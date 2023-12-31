import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailedItemWidget extends StatelessWidget {
  const DetailedItemWidget({
    Key? key,
    this.isBlackTextColor = false,
    this.customSubtitle,
    this.leading,
    this.subtitle,
    this.imageIcon,
    required this.title,
  }) : super(key: key);

  final Widget? customSubtitle;

  final String? subtitle;

  final Widget? leading;

  final String? imageIcon;

  final String title;

  final bool isBlackTextColor;

  final String assetsPath = 'assets/images/detailed_task';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: (leading == null)
          ? Padding(
              padding: const EdgeInsets.only(left: 12),
              child: SvgPicture.asset('$assetsPath/$imageIcon.svg'),
            )
          : leading,
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          title,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF9A9A9A),
          ),
        ),
      ),
      subtitle: (customSubtitle == null)
          ? Text(
              subtitle ?? '',
              style: (isBlackTextColor)
                  ? const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )
                  : const TextStyle(
                      color: Color(0xFF9A9A9A),
                      fontStyle: FontStyle.italic,
                    ),
            )
          : customSubtitle,
    );
  }
}
