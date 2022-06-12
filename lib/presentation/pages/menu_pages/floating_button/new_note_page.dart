import 'package:flutter/material.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/app_bar.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/confirm_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/white_box_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/color_pallete_widget.dart';

class AddQuickNote extends StatelessWidget {
  AddQuickNote({Key? key}) : super(key: key);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBarCustom(title: 'Add Note'),
          WhiteBoxWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 120),
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                    ),
                    subtitle: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your description:',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ConfirmButtonWidget(onPressed: () {}, title: 'Add Task'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
