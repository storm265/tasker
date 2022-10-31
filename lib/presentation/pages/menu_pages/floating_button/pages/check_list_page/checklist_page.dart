import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/controller/check_list_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/widgets/add_item_button.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/pages/check_list_page/widgets/check_box_widget.dart';
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

class CheckListPage extends StatefulWidget {
  const CheckListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  final _scrollController = ScrollController();
  final _checkListController = getIt<CheckListController>();

  @override
  void dispose() {
    _checkListController.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    final navigationController =
        NavigationInherited.of(context).navigationController;
    return AppbarWrapWidget(
      resizeToAvoidBottomInset: false,
      navRoute: Pages.quick,
      isRedAppBar: true,
      title: LocaleKeys.add_check_list.tr(),
      showLeadingButton: true,
      isPopFromNavBar: true,
      child: Stack(
        children: [
          const FakeAppBar(),
          WhiteBoxWidget(
            scrollController: _scrollController,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _checkListController.formKey,
                      child: TitleWidget(
                        textInputType: TextInputType.multiline,
                        maxLength: 256,
                        textController: _checkListController.titleController,
                        title: LocaleKeys.title.tr(),
                        onEdiditionCompleteCallback: () =>
                            FocusScope.of(context).unfocus(),
                      ),
                    ),
                    subtitle:
                        ValueListenableBuilder<List<Map<String, dynamic>>>(
                      valueListenable: _checkListController.checkBoxItems,
                      builder: (_, items, __) => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (_, i) {
                          index = i;
                          return CheckBoxWidget(
                            checkBoxController: _checkListController,
                            index: i,
                          );
                        },
                      ),
                    ),
                  ),
                  AddItemButton(onPressed: () async {
                    _checkListController.addCheckboxItem(index);
                    await _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent + 20,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  }),
                  Column(
                    children: [
                      ColorPalleteWidget(
                        colorController:
                            _checkListController.colorPalleteController,
                      ),
                      const SizedBox(height: 40),
                      ValueListenableBuilder<bool>(
                        valueListenable: _checkListController.isEditStatus,
                        builder: (context, isEdit, _) =>
                            ValueListenableBuilder<bool>(
                          valueListenable: _checkListController.isClickedButton,
                          builder: (context, isClicked, _) => isClicked
                              ? ConfirmButtonWidget(
                                  title: isEdit
                                      ? LocaleKeys.update.tr()
                                      : LocaleKeys.done.tr(),
                                  onPressed: isClicked
                                      ? () async {
                                          await _checkListController
                                              .tryValidateCheckList(
                                            navigationController:
                                                navigationController,
                                            context: context,
                                          );
                                        }
                                      : null,
                                )
                              : ActivityIndicatorWidget(
                                  text: LocaleKeys.validating.tr(),
                                ),
                        ),
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
