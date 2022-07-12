import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/auth/welcome/widgets/assets_content.dart';

class AsseterWidget extends StatelessWidget {
  final Function(int index) onChange;
  final List _assetList = [Walkthrough1(), Walkthrough2(), Walkthrough3()];
  AsseterWidget({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: _assetList.length,
      onPageChanged: onChange,
      itemBuilder: (_, index) {
        final assets = _assetList[index];
        return Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  '${assets.assetsPath}${assets.avatarsTitle}.png',
                  height: 230,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  assets.titleText,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  assets.subText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
