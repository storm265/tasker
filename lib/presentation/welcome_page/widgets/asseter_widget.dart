import 'package:flutter/material.dart';
import 'package:todo2/presentation/welcome_page/widgets/assets_content.dart';

class AsseterWidget extends StatefulWidget {
  final Size size;

  final Function(int index) onChange;
  const AsseterWidget({Key? key, required this.size, required this.onChange})
      : super(key: key);

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
          return Stack(
            children: [
              Positioned(
                top: widget.size.height * 0.10,
                left: widget.size.width * 0.125,
                child: Image.asset(
                    '${AssetsContent.assetsPath}${AssetsContent.avatarsTitles[index]}.png'),
              ),
              Positioned(
                top: widget.size.height * 0.50,
                left: widget.size.width * 0.25,
                child: Text(
                  AssetsContent.firstText[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 24,
                  ),
                ),
              ),
              Positioned(
                top: widget.size.height * 0.555,
                left: widget.size.width * 0.18,
                child: Text(
                  AssetsContent.secondText[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
