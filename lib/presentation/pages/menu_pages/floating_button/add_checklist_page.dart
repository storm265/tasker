import 'package:flutter/material.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/app_bar.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/confirm_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/white_box_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/color_pallete_widget.dart';

class AddCheckListPage extends StatefulWidget {
  const AddCheckListPage({Key? key}) : super(key: key);

  @override
  State<AddCheckListPage> createState() => _AddCheckListPageState();
}

class _AddCheckListPageState extends State<AddCheckListPage> {
  int _selectedIndex = 0;

  int _items = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBarCustom(title: 'Add Check List'),
          WhiteBoxWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: ListTile(
                      title: const Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(
                          'Title',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: _items,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Checkbox(
                                        checkColor:
                                            Colors.orange.withOpacity(0.5),
                                        activeColor: Colors.grey,
                                        value: false,
                                        onChanged: (value) {}),
                                    Text('Checklist item $index'),
                                  ],
                                );
                              }),
                          TextButton(
                            onPressed: () => setState(() {
                              _items++;
                            }),
                            child: const Text('+ Add new item '),
                          )
                        ],
                      )),
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
                    ColorPalleteWidget(selectedIndex: _selectedIndex),
                    ConfirmButtonWidget(onPressed: () {}, title: 'Done'),
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
