import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/circle_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class UndoneItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const UndoneItemWidget(
      {Key? key, required this.subtitle, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomPaint(
          size: const Size(20, 20),
          painter: CirclePainter(circleColor: colors[0]),
        ),
      ),
      subtitle: Text(subtitle),
      title: Text(title),
    );
  }
}
