import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/new_task/grey_container.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GreyContainerWidget(
      child: Padding(
        padding: EdgeInsets.only(left: 25, top: 10),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Title',
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
