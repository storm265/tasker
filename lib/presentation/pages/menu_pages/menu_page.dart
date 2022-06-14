import 'package:flutter/material.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/model/supabase/projects_model.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_glow_single_child_scroll_widget.dart';

import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/add_project_button.dart';
import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/category_length_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/category_widget.dart';
import 'package:todo2/presentation/widgets/menu_pages/menu_page/widgets/circle_widget.dart';

// TODO statefull +
class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _projectsRepository = ProjectRepositoryImpl();
  List<ProjectModel> _projects = [];
  @override
  void initState() {
    getInitData();
    super.initState();
  }

  Future<void> getInitData() async {
    _projects = await _projectsRepository.fetchProject();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Projects', appBarColor: Colors.white),
      body: DisabledGlowWidget(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              FutureBuilder<List<ProjectModel>>(
                future: _projectsRepository.fetchProject(),
                builder: (_, AsyncSnapshot<List<ProjectModel>> snapshot) {
                  if (snapshot.data == null) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.data!.isEmpty) {
                    return const SizedBox();
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
                          return Container(
                            width: 140,
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Stack(
                              children: [
                                CircleWidget(
                                    color: snapshot.data![index].color ?? ''),
                                CategoryWidget(
                                    title: snapshot.data![index].title ?? ''),
                                const CategoryLengthWidget()
                              ],
                            ),
                          );
                        });
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const AddProjectButton()
            ],
          ),
        ),
      ),
    );
  }
}
