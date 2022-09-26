import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/circle_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class ProjectPanelPickerWidget extends StatelessWidget {
  ProjectPanelPickerWidget({Key? key}) : super(key: key);
  final taskController = AddTaskController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProjectModel>>(
      initialData: const [],
      future: taskController.projectController
          .searchProject(title: taskController.projectTextController.text),
      builder: (context, AsyncSnapshot<List<ProjectModel>> snapshot) {
        log('snapshot.data ${snapshot.data}');
        return (!snapshot.hasData || snapshot.data == null)
            ? Center(
                child: ProgressIndicatorWidget(
                  text: LocaleKeys.loaing.tr(),
                ),
              )
            : ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      taskController.changePanelStatus(
                          newStatus: InputFieldStatus.hide);
                    },
                    child: ListTile(
                      onTap: () => taskController.pickProject(
                        newProject: data,
                        context: context,
                      ),
                      leading: DoubleCircleWidget(
                        color: data.color,
                      ),
                      title: Text(data.title),
                    ),
                  );
                },
              );
      },
    );
  }
}
