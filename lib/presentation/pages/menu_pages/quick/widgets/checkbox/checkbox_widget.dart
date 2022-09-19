import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/database/model/checklist_model.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/checkbox/checkbox_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/common_widgets/color_line_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/common_widgets/shadow_decoration.dart';
import 'package:todo2/presentation/pages/menu_pages/quick/widgets/common_widgets/title_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/endpane_widget.dart';
import 'package:todo2/presentation/widgets/common/slidable_widgets/grey_slidable_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/utils/assets_path.dart';

class CheckboxWidget extends StatelessWidget {
  final CheckListModel checklistModel;
  final NavigationController navigationController;
  final CheckListController checkListController;

  
  const CheckboxWidget({
    Key? key,
    required this.checklistModel,
    required this.navigationController,
    required this.checkListController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          EndPageWidget(
            iconPath: AssetsPath.editIconPath,
            onClick: () async {
              checkListController.pickEditData(pickedModel: checklistModel);
              await navigationController.moveToPage(Pages.addCheckList);
            },
          ),
          const GreySlidableWidget(),
          EndPageWidget(
            iconPath: AssetsPath.deleteIconPath,
            onClick: () async {
              await checkListController.deleteChecklist(
                  checkListModel: checklistModel);
            },
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: shadowDecoration,
          child: Stack(
            children: [
              ColorLineWidget(color: checklistModel.color),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Column(
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
