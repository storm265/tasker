import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_task/controller/add_task_controller.dart';

class DescriptionFieldWidget extends StatelessWidget {
  const DescriptionFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFEAEAEA), width: 1),
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(5), left: Radius.circular(5)),
                    color: const Color(0xFFF8F8F8),
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Transform.rotate(
                        angle: 43.1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.attachment_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () => newTaskConroller.pickAvatar(),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return SizedBox(
                width: 100,
                height: 200,
                child: Image.file(File(newTaskConroller.imageList[index])),
              );
            },
            itemCount: newTaskConroller.imageList.length,
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
