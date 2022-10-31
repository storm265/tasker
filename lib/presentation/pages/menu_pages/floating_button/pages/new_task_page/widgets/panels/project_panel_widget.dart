import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/panel_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/circle_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/controller/base_tasks.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';

class ProjectPanelPickerWidget extends StatelessWidget {
  final BaseTasks addEditTaskController;
  const ProjectPanelPickerWidget({
    Key? key,
    required this.addEditTaskController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProjectModel>>(
      initialData: const [],
      future: addEditTaskController.projectController.searchProject(
          title: addEditTaskController.projectTextController.text),
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
                      addEditTaskController.panelProvider
                          .changePanelStatus(newStatus: PanelStatus.hide);
                    },
                    child: ListTile(
                      onTap: () => addEditTaskController.pickProject(
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
