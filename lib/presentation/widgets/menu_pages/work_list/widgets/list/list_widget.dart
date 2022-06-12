import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/circle_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/list/text.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/work_list/widgets/slidable_widgets/grey_slidable_widget.dart';

class ListWidget extends StatelessWidget {
  final int index;
  const ListWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListDayWidget(date: DateTime.now(), index: index),
          Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                EndPageWidget(icon: Icons.edit, onClick: () {}),
                const GreySlidableWidget(),
                EndPageWidget(icon: Icons.delete, onClick: () {}),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                child: Stack(
                  children: [
                    Positioned(
                      top: 25,
                      left: 382,
                      child: SizedBox(
                        width: 5,
                        height: 25,
                        child: ColoredBox(
                          color: index % 2 == 0 ? colors[0] : Palette.red,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: index % 2 == 0
                              ? CustomPaint(
                                  size: const Size(20, 20),
                                  painter:
                                      CirclePainter(circleColor: colors[0]))
                              : const Icon(Icons.check_circle,
                                  color: Palette.red)),
                      subtitle: Text('Slide me',
                          style: index % 2 == 0
                              ? const TextStyle()
                              : const TextStyle(
                                  decoration: TextDecoration.lineThrough)),
                      title: Text(
                        'Slide me',
                        style: index % 2 == 0
                            ? const TextStyle()
                            : const TextStyle(
                                decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
