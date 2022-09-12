import 'package:flutter/material.dart';

class RemoveAllItemsWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const RemoveAllItemsWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          top: 10,
          bottom: 10,
        ),
        child: GestureDetector(
          onTap: onPressed,
          child: Row(
            children: const [
              Icon(
                Icons.remove,
                color: Colors.grey,
              ),
              Text(
                'Remove all items',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
