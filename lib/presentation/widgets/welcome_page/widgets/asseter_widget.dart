import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/welcome_page/widgets/assets_content.dart';

class AsseterWidget extends StatelessWidget {
  final Function(int index) onChange;
  final List _assetList = [Walkthrough1(), Walkthrough2(), Walkthrough3()];
  AsseterWidget({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: PageView.builder(
        itemCount: _assetList.length,
        onPageChanged: onChange,
        itemBuilder: (_, index) {

          dynamic _assets = _assetList[index];
          return Stack(
            children: [
              Positioned(
                top: 100,
                left: _assets.imgLeft,
                child: Image.asset(
                  '${_assets.assetsPath}${_assets.avatarsTitle}.png',
                ),
              ),
              Positioned(
                top: 345,
                left: _assets.titleTextLeft,
                child: Text(
                  _assets.titleText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 24,
                  ),
                ),
              ),
              Positioned(
                top: 385,
                left: _assets.subTextLeft,
                child: Text(
                  _assets.subText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
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
