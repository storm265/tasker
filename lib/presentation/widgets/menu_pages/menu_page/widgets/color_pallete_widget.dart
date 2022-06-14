import 'package:flutter/material.dart';

import 'package:todo2/presentation/widgets/common/colors.dart';

// ignore: must_be_immutable
class ColorPalleteWidget extends StatefulWidget {
  int selectedIndex;
  ColorPalleteWidget({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<ColorPalleteWidget> createState() => _ColorPalleteWidgetState();
}

class _ColorPalleteWidgetState extends State<ColorPalleteWidget> {
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
            child: GestureDetector(
              onTap: () => setState(
                (() {
                  widget.selectedIndex = index;
                  // print(widget.selectedIndex);
                }),
              ),
              child: Container(
                width: 48,
                height: 48,
                child: Icon(
                  (widget.selectedIndex == index) ? Icons.done : null,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: colors[index],),
              ),
            ),
          );
        }),
      ),
    );
  }
}
