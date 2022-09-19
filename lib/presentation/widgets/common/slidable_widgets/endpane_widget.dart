import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class EndPageWidget extends StatelessWidget {
  final VoidCallback onClick;
  final String? iconPath;
  final IconData? icon;
  final Color color;
  const EndPageWidget({
    Key? key,
    this.iconPath,
    required this.onClick,
    this.color = Palette.red,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE0E0E0).withOpacity(0.5),
              offset: const Offset(1, 0),
              blurRadius: 9,
            )
          ]),
      child: Center(
        child: IconButton(
          icon: iconPath == null
              ? Icon(
                  icon,
                  color: color,
                )
              : SvgPicture.asset(
                  iconPath!,
                  color: color,
                ),
          onPressed: () async {
            await Slidable.of(context)?.close();
            onClick();
          },
        ),
      ),
    );
  }
}
