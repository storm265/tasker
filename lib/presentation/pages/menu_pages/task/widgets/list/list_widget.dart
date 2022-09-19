import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/presentation/pages/menu_pages/task/detailed_page/detailed_task.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/task_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/list/text.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/utils/assets_path.dart';

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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListDayWidget(date: DateTime.now(), index: index),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      EndPageWidget(
                        iconPath: AssetsPath.editIconPath,
                        onClick: () {},
                      ),
                      const GreySlidableWidget(),
                      EndPageWidget(
                        iconPath: AssetsPath.deleteIconPath,
                        onClick: () {},
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => const DetailedTaskPage(),
                    ),
                    child: TaskCardWidget(data: data),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
