import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/dialogs/options_dialog.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/add_project_button.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/category_length_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/category_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/circle_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/presentation/widgets/common/progress_indicator_widget.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapper.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _projectsRepository = ProjectRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return WillPopWrapper(
      child: AppbarWrapperWidget(
        title: 'Projects',
        isRedAppBar: false,
        child: DisabledGlowWidget(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  FutureBuilder<List<ProjectModel>>(
                    future: _projectsRepository.fetchProject(),
                    builder: (_, AsyncSnapshot<List<ProjectModel>> snapshot) {
                      if (snapshot.data == null) {
                        return const ProgressIndicatorWidget();
                      } else if (snapshot.hasData) {
                        return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                            ),
                            itemBuilder: (BuildContext context, index) {
                              final data = snapshot.data![index];
                              return Padding(
                                padding: const EdgeInsets.all(4),
                                child: InkWell(
                                  onLongPress: () => showOptionsDialog(context),
                                  child: Container(
                                    width: 140,
                                    height: 180,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: DoubleCircleWidget(
                                              color: data.color,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Wrap(
                                              spacing: 5,
                                              direction: Axis.vertical,
                                              children: [
                                                CategoryWidget(
                                                    title: data.title),
                                                const CategoryLengthWidget(
                                                    taskLenght: 10)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  AddProjectButton(
                    notifyParent: () => setState(() {}),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
