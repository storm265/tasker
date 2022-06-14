import 'package:flutter/material.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/confirm_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/red_app_bar.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/title_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/white_box_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/add_check_list_widgets/chose_color_text.dart';
import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/color_pallete_widget.dart';

class AddQuickNote extends StatelessWidget {
  AddQuickNote({Key? key}) : super(key: key);
  final descriptionTextController = TextEditingController();
  int selectedColorIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        appBarColor: Palette.red,
        textColor: Colors.white,
        title: 'Add Note',
        showLeadingButton: true,
      ),
      body: Stack(
        children: [
          redAppBar,
          WhiteBoxWidget(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TitleWidget(
                    textController: descriptionTextController,
                    title: 'Description',
                  ),
                ),
                const SizedBox(height: 100),
                Column(
                  children: [
                    choseColorText,
                    ColorPalleteWidget(selectedIndex: selectedColorIndex),
                    ConfirmButtonWidget(
                      onPressed: () {
                        print(descriptionTextController.text);
                        print(selectedColorIndex);
                      },
                      title: 'Done',
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
