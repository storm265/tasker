import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

import 'package:todo2/presentation/widgets/menu_pages/menu_page/dialog.dart';

class AddProjectButton extends StatelessWidget {
  final Function notifyParent;
  const AddProjectButton({Key? key, required this.notifyParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async =>
          await showMaterialDialog(context).then((_) => notifyParent()),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ProjectColor.getColor(CategoryColor.blue),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
