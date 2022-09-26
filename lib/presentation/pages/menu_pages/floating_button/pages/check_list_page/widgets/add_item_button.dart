import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';

class AddItemButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddItemButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          top: 10,
          bottom: 10,
        ),
        child: GestureDetector(
          onTap: onPressed,
          child: Text(
            LocaleKeys.add_new_item.tr(),
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
