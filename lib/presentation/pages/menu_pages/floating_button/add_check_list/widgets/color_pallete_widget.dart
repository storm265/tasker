import 'package:flutter/material.dart';

import 'package:todo2/presentation/widgets/common/colors.dart';

// ignore: must_be_immutable
class ColorPalleteWidget extends StatelessWidget {
  int selectedIndex;
  ColorPalleteWidget({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        width: 300,
        height: 48,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onTap: () => setState((() => selectedIndex = index)),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: colors[index],
                  ),
                  child: (selectedIndex == index)
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
