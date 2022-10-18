import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/database/model/task_models/task_model.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_text_field.dart';
import 'package:todo2/presentation/pages/menu_pages/task/view_task/controller/view_task_controller.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/utils/assets_path.dart';

class DescriptionBoxWidget extends StatefulWidget {
  final TaskModel? pickedTask;
  final bool withImageIcon;
  final String? hintText;
  final AttachmentsProvider attachmentsProvider;
  final TextEditingController textController;
  final ViewTaskController? viewTaskController;
  final VoidCallback? callback;
  const DescriptionBoxWidget({
    super.key,
    this.withImageIcon = false,
    required this.attachmentsProvider,
    required this.textController,
    this.hintText,
    this.pickedTask,
    this.callback,
    this.viewTaskController,
  });

  @override
  State<DescriptionBoxWidget> createState() => _DescriptionBoxWidgetState();
}

class _DescriptionBoxWidgetState extends State<DescriptionBoxWidget> {
  bool isActiveButton = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFEAEAEA),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DescriptionTextField(
            descriptionTextController: widget.textController,
            hintText: widget.hintText,
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
                  widget.withImageIcon
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: GestureDetector(
                            onTap: () async {
                              final image = await widget
                                  .attachmentsProvider.fileProvider
                                  .pickAvatar(context: context);
                              widget.attachmentsProvider
                                  .addAttachment(attachment: image);
                            },
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
                        final file = await widget
                            .attachmentsProvider.fileProvider
                            .pickFile(context: context);
                        widget.attachmentsProvider
                            .addAttachment(attachment: file);
                      },
                      child:
                          SvgPicture.asset(AssetsPath.fileAttachmentIconPath),
                    ),
                  ),
                  const Spacer(),
                  widget.withImageIcon
                      ? TextButton(
                          onPressed: isActiveButton
                              ? () async {
                                  // await widget.attachmentsProvider
                                  //     .up(
                                  //         taskId: widget.pickedTask?.id ?? '');
                                  if (widget.viewTaskController != null) {
                                    await widget.viewTaskController!
                                        .createTaskComment(
                                      taskId: widget.pickedTask!.id,
                                    );
                                    widget.textController.clear();
                                    widget.callback!();
                                  }
                                  setState(() {
                                    isActiveButton = true;
                                  });
                                }
                              : null,
                          child: Text(
                            LocaleKeys.send.tr(),
                            style: TextStyle(
                              fontSize: 17,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w200,
                              color: getAppColor(color: CategoryColor.blue),
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
    );
  }
}
