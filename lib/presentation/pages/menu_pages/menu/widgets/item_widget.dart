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
    return Container(
      width: 140,
      height: 180,
      color: Colors.white,
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
                alignment: Alignment.bottomLeft,
                child: Column(
              
                  children: [
                    CategoryWidget(title: model.title),
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
    );
  }
}
