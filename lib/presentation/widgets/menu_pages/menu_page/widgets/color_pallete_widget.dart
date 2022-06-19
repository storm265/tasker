import 'package:flutter/material.dart';
import 'package:todo2/controller/add_tasks/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

// ignore: must_be_immutable
class ColorPalleteWidget extends StatelessWidget {
  final ColorPalleteController colorController;
  const ColorPalleteWidget({Key? key, required this.colorController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        shrinkWrap: true,
        itemBuilder: ((_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ValueListenableBuilder(
              valueListenable: colorController.selectedIndex,
              builder: (context, value, _) {
                return GestureDetector(
                  onTap: () => colorController.changeSelectedIndex(index),
                  child: Container(
                    width: 48,
                    height: 48,
                    child: Icon(
                      (colorController.selectedIndex.value == index)
                          ? Icons.done
                          : null,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: colors[index],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
