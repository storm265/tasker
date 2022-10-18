import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_provider/color_pallete_provider.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class ColorPalleteWidget extends StatelessWidget {
  final ColorPalleteProvider colorController;
  const ColorPalleteWidget({
    Key? key,
    required this.colorController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: colorController.selectedIndex,
      builder: (__, selectedIndex, _) => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 15,
                bottom: 15,
                right: 15,
              ),
              child: Text(
                LocaleKeys.choose_color.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
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
                        onTap: () => colorController.changeSelectedIndex(i),
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
                        fontSize: 12,
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
