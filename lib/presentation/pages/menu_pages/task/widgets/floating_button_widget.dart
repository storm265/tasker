import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/add_dialog.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 23),
      child: GestureDetector(
        // onTap: () => showAddDialog(context),
        child: Container(
          width: 55,
          height: 55,
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
                color: Colors.white,
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
