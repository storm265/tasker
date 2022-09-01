import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/inherited_checklist_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/checkbox/checkbox_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/color_line_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/shadow_decoration.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/widgets/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class CheckBoxCard extends StatelessWidget {
  final CheckListModel checklistModel;

  final NavigationController navigationController;
  CheckBoxCard({
    Key? key,
    required this.checklistModel,
    required this.navigationController,
  }) : super(key: key);
  final checkListController = CheckListSingleton().controller;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          EndPageWidget(
            icon: Icons.edit,
            onClick: () {
              checkListController.pickEditData(checklistModel: checklistModel);
              navigationController.moveToPage(Pages.addCheckList);
            },
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
        child: Container(
          decoration: shadowDecoration,
          child: Stack(
            children: [
              ColorLineWidget(color: checklistModel.color),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TitleWidget(title: checklistModel.title),
                    CheckBoxWidget(data: checklistModel.items),
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
