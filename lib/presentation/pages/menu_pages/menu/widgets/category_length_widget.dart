import 'package:flutter/material.dart';

class CategoryLengthWidget extends StatelessWidget {
  final int taskLenght;
  const CategoryLengthWidget({Key? key,required this.taskLenght}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
        '$taskLenght tasks',
        style:const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      );
  }
}
