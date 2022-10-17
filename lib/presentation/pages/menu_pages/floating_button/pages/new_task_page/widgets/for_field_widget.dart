import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/add_task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/panel_provider.dart';

class ForTextFieldWidget extends StatelessWidget {
  final AddEditTaskController addEditTaskController;
  final VoidCallback callback;
  const ForTextFieldWidget({
    Key? key,
    required this.callback,
    required this.addEditTaskController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(
            LocaleKeys.forr.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 18,
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          width: 100,
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              ValueListenableBuilder(
                valueListenable: addEditTaskController.pickedUser,
                builder: (_, user, __) => user == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          radius: 19,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                            user.avatarUrl,
                            headers: addEditTaskController.imageHeader,
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onChanged: (_) async => callback(),
                  onTap: () {
                    addEditTaskController.userTextController.clear();
                    addEditTaskController.panelProvider.changePanelStatus(
                      newStatus: PanelStatus.showUserPanel,
                    );
                  },
                  controller: addEditTaskController.userTextController,
                  onEditingComplete: () {
                    addEditTaskController.panelProvider
                        .changePanelStatus(newStatus: PanelStatus.hide);
                    FocusScope.of(context).unfocus();
                  },
                  decoration: const InputDecoration(
                    hintText: 'Assignee',
                    hintStyle:    TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
