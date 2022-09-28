import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/widgets/detailted_options_dialog.dart';
import 'package:todo2/utils/assets_path.dart';

class IconPanelWidget extends StatelessWidget {
  const IconPanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
        IconButton(
          onPressed: () async {
            showDetailedOptions(context);
          },
          icon: SvgPicture.asset(AssetsPath.settingsIconPath),
        ),
      ],
    );
  }
}
