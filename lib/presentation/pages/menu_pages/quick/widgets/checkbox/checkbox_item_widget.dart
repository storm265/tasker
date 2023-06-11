import 'package:flutter/material.dart';
import 'package:todo2/domain/model/checklist_item_model.dart';

class CheckBoxWidget extends StatelessWidget {
  final List<CheckListItemModel> data;
  const CheckBoxWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const SizedBox()
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(3),
                        color: data[index].isCompleted
                            ? Colors.grey
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        data[index].content,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: data[index].isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
  }
}
