import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/checklist_singleton.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/checkbox/checkbox_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/color_line_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/shadow_decoration.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class CheckboxWidget extends StatelessWidget {
  final CheckListModel checklistModel;
  final NavigationController navigationController;
  final VoidCallback callback;
  CheckboxWidget({
    Key? key,
    required this.checklistModel,
    required this.navigationController,
    required this.callback,
  }) : super(key: key);
  final checkListController = CheckListSingleton().controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            const GreySlidableWidget(),
            EndPageWidget(
              icon: Icons.edit,
              onClick: () async {
                checkListController.pickEditData(
                    checklistModel: checklistModel);
                await navigationController.moveToPage(Pages.addCheckList);
              },
            ),
            const GreySlidableWidget(),
            EndPageWidget(
              icon: Icons.delete,
              onClick: () async {
                await checkListController.deleteCheckList(
                    checkListModel: checklistModel);
                callback();
              },
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.only(left: 12),
          
            decoration: shadowDecoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ColorLineWidget(color: checklistModel.color),
                TitleWidget(title: checklistModel.title),
                CheckBoxWidget(data: checklistModel.items),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
