import 'package:flutter/material.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';


class EndPageWidget extends StatelessWidget {
  final VoidCallback onClick;
  final IconData icon;
  const EndPageWidget({Key? key, required this.icon, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 3),
          ],
        ),
        child: Icon(icon, color: Palette.red),
      ),
    );
  }
}
