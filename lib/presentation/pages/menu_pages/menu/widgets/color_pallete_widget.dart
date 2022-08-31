import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class ColorPalleteWidget extends StatelessWidget {
  final ColorPalleteController colorController;
  const ColorPalleteWidget({Key? key, required this.colorController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: colorController.selectedIndex,
      builder: (__, selectedIndex, _) => Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: 15,
                bottom: 15,
                right: 15,
              ),
              child: Text(
                'Choose Color',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            height: 48,
            child: DisabledGlowWidget(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: colors.length,
                shrinkWrap: true,
                itemBuilder: ((_, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: GestureDetector(
                        onTap: () => colorController.changeSelectedIndex(index),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: colors[index],
                          ),
                          child: Icon(
                            (selectedIndex == index) ? Icons.done : null,
                            color: Colors.white,
                          ),
                        ),
                      ));
                }),
              ),
            ),
          ),
          colorController.isNotPickerColor
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 15,
                      right: 15,
                    ),
                    child: Text(
                      colorController.isNotPicked,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
// solution with key
/*
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class ColorPalleteWidget extends StatelessWidget {
  final ColorPalleteController colorController;
  const ColorPalleteWidget({Key? key, required this.colorController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      validator: (state) {
        if (colorController.isNotPickerColor) {
          return 'Please, pick color!';
        } else {
          return null;
        }
      },
      builder: (state) => ValueListenableBuilder<int>(
        valueListenable: colorController.selectedIndex,
        builder: (__, selectedIndex, _) => Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 15,
                  bottom: 15,
                  right: 15,
                ),
                child: Text(
                  'Choose Color',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 48,
              child: DisabledGlowWidget(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  shrinkWrap: true,
                  itemBuilder: ((_, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: GestureDetector(
                        onTap: () {
                          colorController.changeSelectedIndex(i);
                          state.didChange(selectedIndex);
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: colors[i],
                          ),
                          child: Icon(
                            (selectedIndex == i) ? Icons.done : null,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 15,
                  right: 15,
                ),
                child: Text(
                  state.errorText ?? '',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/