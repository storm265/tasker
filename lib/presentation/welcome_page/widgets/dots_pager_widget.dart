import 'package:flutter/material.dart';

class DotsPagerWidget extends StatelessWidget {
  final Size size;
  final int pageIndex;
  const DotsPagerWidget({Key? key, required this.pageIndex, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.64,
      left: size.width * 0.425,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: CircleAvatar(
                backgroundColor:
                    (pageIndex == 0) ? Colors.black : Colors.black45,
                radius: 5),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: CircleAvatar(
                backgroundColor:
                    (pageIndex == 1) ? Colors.black : Colors.black45,
                radius: 5),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: CircleAvatar(
                backgroundColor:
                    (pageIndex == 2) ? Colors.black : Colors.black45,
                radius: 5),
          ),
        ],
      ),
    );
  }
}
