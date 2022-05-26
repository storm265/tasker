import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/welcome_page/widgets/assets_content.dart';

class AsseterWidget extends StatefulWidget {
  final Function(int index) onChange;
  const AsseterWidget({Key? key, required this.onChange}) : super(key: key);

  @override
  State<AsseterWidget> createState() => _AsseterWidgetState();
}

class _AsseterWidgetState extends State<AsseterWidget> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: 3,
        onPageChanged: widget.onChange,
        itemBuilder: (context, index) {
          return Stack(children: [
            Positioned(
              top: 100,
              left: 50,
              child: Image.asset(
                  '${AssetsContent.assetsPath}${AssetsContent.avatarsTitles[index]}.png'),
            ),
            Positioned(
              top: 345,
              left: 100,
              child: Text(
                AssetsContent.firstText[index],
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 24,
                ),
              ),
            ),
            Positioned(
                top: 385,
                left: 70,
                child: Text(AssetsContent.secondText[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    )))
          ]);
        });
  }
}
