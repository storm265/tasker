import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned(
        top: 125,
        left: 23,
        child: Text('Personal',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w300)));
  }
}
