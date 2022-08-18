import 'package:flutter/material.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/category_length_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/category_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/circle_widget.dart';

class ProjectItemWidget extends StatelessWidget {
  final ProjectModel model;
  final int taskLength;
  const ProjectItemWidget({
    Key? key,
    required this.model,
    required this.taskLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 140,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 0.5,
              blurRadius: 4,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: DoubleCircleWidget(
                  color: model.color,
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryWidget(title: model.title),
                      const SizedBox(height: 5),
                      CategoryLengthWidget(taskLength: taskLength)
                    ],
                  )
                  //  Wrap(
                  //   spacing: 5,
                  //   direction: Axis.vertical,
                  //   children: [

                  //     CategoryWidget(title: model.title),
                  //     CategoryLengthWidget(taskLength: taskLength)
                  //   ],
                  // ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
