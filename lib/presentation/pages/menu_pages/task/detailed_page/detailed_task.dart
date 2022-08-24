import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/new_note/widgets/atachment_message_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/widgets/confirm_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/detailed_page/widgets/comment_button.dart';
import 'package:todo2/presentation/pages/menu_pages/task/detailed_page/widgets/detailed_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/task/detailed_page/widgets/icon_panel.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class DetailedTaskPage extends StatefulWidget {
  const DetailedTaskPage({Key? key}) : super(key: key);
  @override
  State<DetailedTaskPage> createState() => _DetailedTaskPageState();
}

class _DetailedTaskPageState extends State<DetailedTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final detailedController = DetailedPageController();
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      insetPadding: const EdgeInsets.all(25),
      contentPadding: const EdgeInsets.all(0),
      content: SafeArea(
        // TODO maybe remove
        child: WillPopWrap(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SizedBox(
              width: 360,
              height: 700,
              child: DisabledGlowWidget(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const IconPanelWidget(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            const Text(
                              'Meeting according with design team in Central Park',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) => Container(
                                      width: double.infinity,
                                      height: 2, //0.7
                                      color: Colors.grey,
                                    ),
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return const DetailedItemWidget(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 20,
                                        ),
                                        title: 'Assigned to',
                                        subtitle: 'Stephen Chow',
                                      );

                                    case 1:
                                      return const DetailedItemWidget(
                                        imageIcon: 'calendar',
                                        title: 'Due Date',
                                        subtitle: 'Aug 5,2018',
                                      );

                                    case 2:
                                      return const DetailedItemWidget(
                                        isBlackColor: true,
                                        imageIcon: 'description',
                                        title: 'Decription',
                                        subtitle:
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing.',
                                      );

                                    case 3:
                                      return DetailedItemWidget(
                                        imageIcon: 'members',
                                        title: 'Members',
                                        customSubtitle: Row(
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              width: 200,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: 5,
                                                itemBuilder: (context, index) {
                                                  return index == 4
                                                      ? const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      2),
                                                          child: CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor:
                                                                Colors.red,
                                                            child: Icon(Icons
                                                                .more_horiz),
                                                          ),
                                                        )
                                                      : const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: 2,
                                                            left: 2,
                                                            right: 2,
                                                          ),
                                                          child: CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                        );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      );

                                    case 4:
                                      return DetailedItemWidget(
                                        imageIcon: 'tag',
                                        title: 'Tag',
                                        customSubtitle: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 160,
                                            top: 5,
                                          ),
                                          child: Container(
                                            width: 120,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Personal',
                                                style: TextStyle(
                                                  color: getAppColor(
                                                      color:
                                                          CategoryColor.blue),
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );

                                    default:
                                      return const Spacer();
                                  }
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ValueListenableBuilder<bool>(
                        valueListenable:
                            detailedController.isSubmitButtonClicked,
                        builder: (_, isClicked, __) => ConfirmButtonWidget(
                          color: getAppColor(color: CategoryColor.blue),
                          title: 'Complete Task',
                          onPressed: isClicked
                              ? () async {
                                  detailedController
                                      .isSubmitButtonClicked.value = false;
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  detailedController
                                      .isSubmitButtonClicked.value = true;
                                  // without then
                                  // .then((_) =>
                                  //     NavigationService
                                  //         .navigateTo(
                                  //       context,
                                  //       Pages.taskList,
                                  //     ));
                                }
                              : null,
                        ),
                      ),
                      const AttachementWidget(),
                      CommentButton(onClickedCallback: () {})
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      //),
    );
  }
}

class DetailedPageController extends ChangeNotifier {
  final scrollController = ScrollController();
  final isSubmitButtonClicked = ValueNotifier(true);
}
