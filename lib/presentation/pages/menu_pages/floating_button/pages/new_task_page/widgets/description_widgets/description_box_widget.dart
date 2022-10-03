import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/task_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_text_field.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/utils/assets_path.dart';

class DescriptionBoxWidget extends StatelessWidget {
  final AddTaskController taskController;
  final bool withImageIcon;
  final String? hintText;
  const DescriptionBoxWidget({
    super.key,
    this.withImageIcon = false,
    this.hintText,
    required this.taskController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      height: 110,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFEAEAEA),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DescriptionTextField(
              taskController: taskController,
              hintText: hintText,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 23),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFEAEAEA), width: 1),
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(5),
                    left: Radius.circular(5),
                  ),
                  color: const Color(0xFFF8F8F8),
                ),
                width: double.infinity,
                height: 40,
                child: Row(
                  children: [
                    withImageIcon
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: GestureDetector(
                              onTap: () async {},
                              child: SvgPicture.asset(
                                AssetsPath.imageIconIconPath,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GestureDetector(
                        onTap: () async {
                          final file = await taskController.fileController
                              .pickFile(context: context);
                          taskController.addAttachment(attachment: file);
                        },
                        child:
                            SvgPicture.asset(AssetsPath.fileAttachmentIconPath),
                      ),
                    ),
                    withImageIcon
                        ? Padding(
                            padding: const EdgeInsets.only(left: 130),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Send',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w200,
                                  color: getAppColor(color: CategoryColor.blue),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
