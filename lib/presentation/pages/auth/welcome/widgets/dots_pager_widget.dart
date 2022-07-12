import 'package:flutter/material.dart';

class DotsPagerWidget extends StatelessWidget {
  final int pageIndex;
  const DotsPagerWidget({Key? key, required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Align(
        alignment: Alignment.center,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) =>
              DotItemWidget(index: index, pageIndex: pageIndex),
        ),
      ),
    );
  }
}

class DotItemWidget extends StatelessWidget {
  final int pageIndex;
  final int index;
  const DotItemWidget({
    Key? key,
    required this.index,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: CircleAvatar(
        backgroundColor: (index == pageIndex) ? Colors.black : Colors.grey,
        radius: 5,
      ),
    );
  }
}
