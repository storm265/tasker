import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/presentation/pages/auth/welcome/widgets/assets_content.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';

class AsseterWidget extends StatelessWidget {
  final Function(int index) onChange;
  final List _assetList = [Walkthrough1(), Walkthrough2(), Walkthrough3()];
  AsseterWidget({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DisabledGlowWidget(
      child: PageView.builder(
        itemCount: _assetList.length,
        onPageChanged: onChange,
        itemBuilder: (_, index) {
          final assets = _assetList[index];
          return Flex(
            direction: Axis.vertical,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                      '${assets.assetsPath}${assets.avatarsTitle}.svg'),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    assets.titleText,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    assets.subText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
