import 'package:flutter/material.dart';

class AddItemButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddItemButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: onPressed,
          child: const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              '+ Add new item ',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ),
        ));
  }
}
