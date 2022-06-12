import 'package:flutter/material.dart';

import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/app_bar.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/confirm_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/white_box_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/floating_widgets/new_task_widgets/for_in_field_widget.dart';

class NewTaskPage extends StatelessWidget {
  final _titleController = TextEditingController();
  NewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBarCustom(title: 'New Task'),
          //fake nav bar
          Padding(
            padding: const EdgeInsets.only(top: 605),
            child: Container(
              width: double.infinity,
              height: 80,
              color: const Color(0xFF292E4E),
            ),
          ),
          WhiteBoxWidget(
            height: 570,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EnterUserWidget(
                        text: 'For', titleController: _titleController),
                    EnterUserWidget(
                        text: 'In', titleController: _titleController),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 65,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF4F4F4),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 25, top: 10),
                    child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Title',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic))),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    Container(
                      width: 295,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFF4F4F4),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 25, top: 10),
                        child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Title',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic))),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.only(right: 220, bottom: 20, left: 25),
                      child: Text(
                        'Chose color',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 18),
                      ),
                    ),
                    ConfirmButtonWidget(onPressed: () {}, title: 'Add Task'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
