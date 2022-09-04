import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class EndPageWidget extends StatelessWidget {
  final VoidCallback onClick;
  final IconData icon;
  const EndPageWidget({
    Key? key,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      borderRadius: BorderRadius.circular(3),
      onPressed: (_) => onClick(),
      backgroundColor: Colors.white,
      foregroundColor: Palette.red,
      icon: icon,
    );
  }
}
