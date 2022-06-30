import 'package:flutter/material.dart';
import 'package:todo2/database/model/checklist_model.dart';

class ColorLineWidget extends StatelessWidget {
  final String color;
  final int index;
  const ColorLineWidget({
    Key? key,
    required this.color,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 1,
      left: 17,
      child: SizedBox(
        width: 121,
        height: 3,
        child: ColoredBox(
          color: Color(
            int.parse(color[index]),
          ),
        ),
      ),
    );
  }
}
