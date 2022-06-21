import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/add_dialog.dart';

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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF96060), Color(0xFFF96060)],
          ),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
