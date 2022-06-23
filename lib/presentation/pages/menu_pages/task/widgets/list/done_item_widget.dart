import 'package:flutter/material.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class DoneItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const DoneItemWidget({Key? key, required this.subtitle, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.check_circle, color: Palette.red),
      ),
      subtitle: Text(
        title,
        style: const TextStyle(decoration: TextDecoration.lineThrough),
      ),
      title: Text(
        subtitle,
        style: const TextStyle(decoration: TextDecoration.lineThrough),
      ),
    );
  }
}
