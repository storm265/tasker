import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/add_dialog.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showAddDialog(context),
      child: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFF68888), Color(0xFFF96060)],
            ),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '+',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
              ),
            ),
          )),
    );
  }
}
