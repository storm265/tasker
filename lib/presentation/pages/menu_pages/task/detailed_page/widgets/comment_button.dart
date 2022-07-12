import 'package:flutter/material.dart';

class CommentButton extends StatelessWidget {
  final VoidCallback onClickedCallback;
  const CommentButton({Key? key, required this.onClickedCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickedCallback,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Comments',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Image.asset('assets/detailed_task/double_arrow.png'),
            )
          ],
        ),
      ),
    );
  }
}
