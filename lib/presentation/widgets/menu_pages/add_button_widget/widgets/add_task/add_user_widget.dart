import 'package:flutter/material.dart';

import 'package:todo2/controller/add_tasks/add_task/add__task_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class AddUserWidget extends StatefulWidget {
  const AddUserWidget({Key? key}) : super(key: key);

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return (newTaskConroller.chipTitles.value.isEmpty)
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
                      newTaskConroller.chipTitles.value.add(
                          'element: ${newTaskConroller.chipTitles.value.length + 1}');
                    });
                  },
                  fillColor: Colors.grey.withOpacity(0.5),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
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
                itemCount: newTaskConroller.chipTitles.value.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.red,
                        ),
                      ),
                      (index == newTaskConroller.chipTitles.value.length - 1)
                          ? RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  newTaskConroller.chipTitles.value.add(
                                      'element: ${newTaskConroller.chipTitles.value.length + 1}');
                                  _scrollController.jumpTo(_scrollController
                                          .position.maxScrollExtent +
                                      20);
                                });
                              },
                              fillColor: Colors.grey.withOpacity(0.5),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                }));
  }
}
