import 'package:flutter/material.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';
import 'package:todo2/presentation/pages/navigation_page.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/confirm_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/common/red_app_bar.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/white_box_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/add_check_list_widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/add_task/for_in_field_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/new_task/grey_container.dart';
import 'package:todo2/presentation/widgets/menu_pages/add_button_widget/widgets/new_task/pick_date_widget.dart';

class NewTaskPage extends StatefulWidget {
  NewTaskPage({Key? key}) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final _forTextController = TextEditingController(text: 'Assignee');
  final _inTextController = TextEditingController(text: 'Project');
  List<String> chipTitles = [];
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: Scaffold(
        appBar: const AppbarWidget(
          appBarColor: Palette.red,
          textColor: Colors.white,
          title: 'New Task',
          showLeadingButton: true,
        ),
        body: Stack(
          children: [
            redAppBar,
            //fake nav bar
            Padding(
              padding: const EdgeInsets.only(top: 520),
              child: Container(
                width: double.infinity,
                height: 80,
                color: const Color(0xFF292E4E),
              ),
            ),
            WhiteBoxWidget(
              height: 570,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EnterUserWidget(
                        text: 'For',
                        titleController: _forTextController,
                      ),
                      EnterUserWidget(
                        text: 'In',
                        titleController: _inTextController,
                      ),
                    ],
                  ),
                  const GreyContainerWidget(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25, top: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          bottom: 10,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 290,
                        height: 110,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFEAEAEA),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFFF4F4F4),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 25,
                                top: 10,
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Title',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: Transform.rotate(
                                    angle: 43.1,
                                    child: const Icon(
                                      Icons.attachment_outlined,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFFEAEAEA), width: 1),
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(5),
                                    left: Radius.circular(5)),
                                color: const Color(0xFFF8F8F8),
                              ),
                              width: double.infinity,
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GreyContainerWidget(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text('Due Date'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 90,
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: colors[0]),
                                onPressed: () {
                                  showCalendarDatePicker(context);
                                },
                                child: const Text('Anytime'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  (chipTitles.isEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      primary: colors[0]),
                                  onPressed: () {},
                                  child: const Text('Anyone'),
                                ),
                              ),
                              RawMaterialButton(
                                onPressed: () {
                                  setState(() {
                                    chipTitles.add(
                                        'element: ${chipTitles.length + 1}');
                                  });
                                },
                                fillColor: Colors.grey.withOpacity(0.5),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                shape: const CircleBorder(),
                              )
                            ],
                          ),
                        )
                      : SizedBox(
                          width: 300,
                          height: 100,
                          child: ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: chipTitles.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      child: CircleAvatar(
                                        radius: 17,
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                    (index == chipTitles.length - 1)
                                        ? RawMaterialButton(
                                            onPressed: () {
                                              setState(() {
                                                chipTitles.add(
                                                    'element: ${chipTitles.length + 1}');
                                                _scrollController.jumpTo(
                                                    _scrollController.position
                                                            .maxScrollExtent +
                                                        20);
                                              });
                                            },
                                            fillColor:
                                                Colors.grey.withOpacity(0.5),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                            shape: const CircleBorder(),
                                          )
                                        : const SizedBox(),
                                  ],
                                );
                              }),
                        ),
                  ConfirmButtonWidget(
                    onPressed: () => pageController.jumpToPage(0),
                    title: 'Add Task',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
