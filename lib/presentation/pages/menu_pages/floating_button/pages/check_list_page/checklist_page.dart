import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/widgets/add_item_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/widgets/check_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/red_app_bar.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/title_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/white_box_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/color_pallete_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class CheckListPage extends StatefulWidget {
  const CheckListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  final _scrollController = ScrollController();
  late final NavigationController _navigationController;

  late final _checkListController = CheckListSingleton();
  @override
  void initState() {
    if (_checkListController.controller.checkBoxItems.value.isEmpty) {
      log('is not edit');
    } else {
      log('is  edit');
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _navigationController =
        NavigationInherited.of(context).navigationController;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _checkListController.controller.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return AppbarWrapWidget(
      navRoute: Pages.quick,
      isRedAppBar: true,
      title: 'Add Check List',
      showLeadingButton: true,
      isPopFromNavBar: true,
      child: Stack(
        children: [
          const FakeAppBar(),
          WhiteBoxWidget(
            scrollController: _scrollController,
            height: 600,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _checkListController.controller.formKey,
                      child: TitleWidget(
                        maxLength: 256,
                        textController:
                            _checkListController.controller.titleController,
                        title: 'Title',
                        onEdiditionCompleteCallback: () =>
                            Focus.of(context).unfocus(),
                      ),
                    ),
                    subtitle: SingleChildScrollView(
                      child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                        valueListenable:
                            _checkListController.controller.checkBoxItems,
                        builder: (_, value, __) => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.length,
                          itemBuilder: (_, i) {
                            index = i;

                            return CheckBoxWidget(
                              checkBoxController:
                                  _checkListController.controller,
                              isClicked:
                                  _checkListController.controller.isChecked,
                              index: i,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  AddItemButton(onPressed: () {
                    _checkListController.controller.addItem(index);
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent + 20,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInCirc,
                    );
                  }),
                  Column(
                    children: [
                      ColorPalleteWidget(
                        colorController: _checkListController
                            .controller.colorPalleteController,
                      ),
                      const SizedBox(height: 40),
                      ValueListenableBuilder<bool>(
                        valueListenable:
                            _checkListController.controller.isClickedButton,
                        builder: (context, isClicked, _) => isClicked
                            ? ConfirmButtonWidget(
                                title: 'Done',
                                onPressed: isClicked
                                    ? () async {
                                        _checkListController.controller
                                            .tryValidateCheckList(
                                          navigationController:
                                              _navigationController,
                                          context: context,
                                          color: colors[_checkListController
                                              .controller
                                              .colorPalleteController
                                              .selectedIndex
                                              .value],
                                          title: _checkListController
                                              .controller.titleController.text,
                                        );
                                      }
                                    : null,
                              )
                            : const ProgressIndicatorWidget(text: 'Saving...'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
