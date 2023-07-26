import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo2/generated/locale_keys.g.dart';

class CommentButtonWidget extends StatelessWidget {
  final VoidCallback onClickedCallback;
  const CommentButtonWidget({
    Key? key,
    required this.onClickedCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickedCallback,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.comments.tr(),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w200,
                fontSize: 17,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: SvgPicture.asset(
                'assets/images/detailed_task/double_arrow.svg',
              ),
            )
          ],
        ),
      ),
    );
  }
}
