import 'package:flutter/material.dart';

class CategoryLengthWidget extends StatelessWidget {
  const CategoryLengthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 155,
      left: 20,
      child: Text(
        '10 tasks',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
