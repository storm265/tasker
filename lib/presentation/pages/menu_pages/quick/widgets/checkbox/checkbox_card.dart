import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/checkbox/checkbox_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/color_line_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/grey_slidable_widget.dart';

class CheckBoxCard extends StatelessWidget {
  final CheckListModel model;
  const CheckBoxCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
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
        child: Card(
          elevation: 3,
          child: Stack(
            children: [
              ColorLineWidget(color: model.color),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TitleWidget(title: model.title),
                    CheckBoxWidget(data: model.items),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
