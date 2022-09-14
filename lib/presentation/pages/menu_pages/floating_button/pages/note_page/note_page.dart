import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/note_page/controller/new_note_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class AddQuickNote extends StatefulWidget {
  const AddQuickNote({Key? key}) : super(key: key);

  @override
  State<AddQuickNote> createState() => _AddQuickNoteState();
}

class _AddQuickNoteState extends State<AddQuickNote> {
  final _addNoteController = NewNoteController();
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
      title: 'Add Note',
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
                      title: 'Description',
                    ),
                    const SizedBox(height: 100),
                    Column(
                      children: [
                        ColorPalleteWidget(
                            colorController:
                                _addNoteController.colorPalleteController),
                        const SizedBox(height: 50),
                        ValueListenableBuilder<bool>(
                          valueListenable: _addNoteController.isEdit,
                          builder: (context, isEdit, _) =>
                              ValueListenableBuilder<bool>(
                            valueListenable: _addNoteController.isButtonClicked,
                            builder: (context, isClicked, _) => isClicked
                                ? ConfirmButtonWidget(
                                    title: isEdit ? 'Update' : 'Done',
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
                                : const ProgressIndicatorWidget(
                                    text: 'Adding note...'),
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
