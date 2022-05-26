import 'package:flutter/material.dart';
import 'package:todo2/presentation/colors.dart';

class AddProjectButton extends StatelessWidget {
  const AddProjectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 30, right: 310),
        child: InkWell(
            onTap: () {},
            child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: menuColors[0]),
                child: const Center(
                    child: Icon(Icons.add, color: Colors.white)))));
  }
}
