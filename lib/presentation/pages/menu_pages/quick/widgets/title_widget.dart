import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_model.dart';

class TitleWidget extends StatelessWidget {
  final int index;
  final List<CheckListModel> data;

  const TitleWidget({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          data[index].title,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
