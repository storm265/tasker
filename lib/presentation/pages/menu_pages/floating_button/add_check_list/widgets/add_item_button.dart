import 'package:flutter/material.dart';

class AddItemButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddItemButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: GestureDetector(
          onTap: onPressed,
          child: const Text(
            '+ Add new item ',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
