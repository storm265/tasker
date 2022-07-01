import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/database/model/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/done_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/text.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/undone_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class ListWidget extends StatelessWidget {
  final int index;
  final List<TaskModel> model;
  const ListWidget({
    Key? key,
    required this.index,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = model[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListDayWidget(date: DateTime.now(), index: index),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: model.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      EndPageWidget(
                        icon: Icons.edit,
                        onClick: () {},
                      ),
                      const GreySlidableWidget(),
                      EndPageWidget(
                        icon: Icons.delete,
                        onClick: () {},
                      ),
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
                            left: 366,
                            child: SizedBox(
                              width: 5,
                              height: 25,
                              child: ColoredBox(
                                color: colors[0],
                              ),
                            ),
                          ),
                          data.isCompleted
                              ? DoneItemWidget(
                                  subtitle: data.dueDate,
                                  title: data.title,
                                )
                              : UndoneItemWidget(
                                  subtitle: data.dueDate,
                                  title: data.title,
                                )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
