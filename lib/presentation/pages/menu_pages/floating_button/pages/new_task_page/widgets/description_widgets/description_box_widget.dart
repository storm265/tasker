import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/controller/attachments_provider.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/new_task_page/widgets/description_widgets/description_text_field.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/utils/assets_path.dart';

class DescriptionBoxWidget extends StatelessWidget {
  final TextEditingController descriptionController;
  final bool withImageIcon;
  final String? hintText;
  final AttachmentsProvider attachmentsProvider;
  const DescriptionBoxWidget({
    super.key,
    this.withImageIcon = false,
    required this.attachmentsProvider,
    this.hintText,
    required this.descriptionController,
  });

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
            descriptionTextController: descriptionController,
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
                            onTap: () async {
                              final image = await attachmentsProvider
                                  .fileProvider
                                  .pickAvatar(context: context);
                              attachmentsProvider.addAttachment(
                                  attachment: image);
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
                        final file = await attachmentsProvider.fileProvider
                            .pickFile(context: context);
                        attachmentsProvider.addAttachment(attachment: file);
                      },
                      child:
                          SvgPicture.asset(AssetsPath.fileAttachmentIconPath),
                    ),
                  ),
                  const Spacer(),
                  withImageIcon
                      ? TextButton(
                          onPressed: () {},
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
