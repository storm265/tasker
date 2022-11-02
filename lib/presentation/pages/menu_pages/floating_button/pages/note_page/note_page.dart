import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/controller/new_note_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/common_widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/activity_indicator_widget.dart';
import 'package:todo2/services/dependency_service/dependency_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class AddQuickNote extends StatefulWidget {
  const AddQuickNote({Key? key}) : super(key: key);

  @override
  State<AddQuickNote> createState() => _AddQuickNoteState();
}

class _AddQuickNoteState extends State<AddQuickNote> {
  final _addNoteController = getIt<NewNoteController>();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _addNoteController.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationController =
        NavigationInherited.of(context).navigationController;
    return AppbarWrapWidget(
      resizeToAvoidBottomInset: false,
      isRedAppBar: true,
      title: LocaleKeys.add_note.tr(),
      showLeadingButton: true,
      isPopFromNavBar: true,
      navRoute: Pages.quick,
      child: Stack(
        children: [
          const FakeAppBar(),
          WhiteBoxWidget(
            height: 600,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TitleWidget(
                      textInputType: TextInputType.multiline,
                      maxLength: 512,
                      textController:
                          _addNoteController.descriptionTextController,
                      title: LocaleKeys.description.tr(),
                    ),
                    const SizedBox(height: 100),
                    Column(
                      children: [
                        ColorPalleteWidget(
                            colorController:
                                _addNoteController.colorPalleteProvider),
                        const SizedBox(height: 50),
                        ValueListenableBuilder<bool>(
                          valueListenable: _addNoteController.isEdit,
                          builder: (context, isEdit, _) =>
                              ValueListenableBuilder<bool>(
                            valueListenable: _addNoteController.isButtonClicked,
                            builder: (context, isClicked, _) => isClicked
                                ? ConfirmButtonWidget(
                                    title: isEdit
                                        ? LocaleKeys.update.tr()
                                        : LocaleKeys.done.tr(),
                                    onPressed: isClicked
                                        ? () async =>
                                            _addNoteController.tryValidateNote(
                                              context: context,
                                              formKey: formKey,
                                              navigationController:
                                                  navigationController,
                                            )
                                        : null,
                                  )
                                : ActivityIndicatorWidget(
                                    text: LocaleKeys.validating.tr(),
                                  ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
