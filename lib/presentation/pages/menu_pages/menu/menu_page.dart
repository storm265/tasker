import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/add_project_button.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_shimmer_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

void ss(BuildContext context) {
  // context.findAncestorStateOfType<_MenuPageState>();
  MenuPageState().updateState();
  // MenuPage.of(context).findAncestorStateOfType<_MenuPageState>();
  MenuPage.of(context).updateState();
}

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  static of(BuildContext context, {bool root = false}) => root
      ? context.findRootAncestorStateOfType<MenuPageState>()
      : context.findAncestorStateOfType<MenuPageState>();
  @override
  State<MenuPage> createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  late TextEditingController _titleController;
  late ProjectController _projectController;

  void updateState() {
    setState(() {});
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    _projectController = ProjectController(
      ProjectRepositoryImpl(
        projectDataSource: ProjectUserDataImpl(
          secureStorageService: SecureStorageSource(),
          network: NetworkSource(),
        ),
      ),
      ColorPalleteController(),
    );
    log('init MenuPage page');
    super.initState();
  }

  @override
  void dispose() {
    _projectController.disposeValues();
    _projectController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppbarWrapWidget(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: AddProjectButton(
        titleController: _titleController,
        projectController: _projectController,
      ),
      isWhite: false,
      title: 'Projects',
      isRedAppBar: false,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              FutureBuilder<List<ProjectModel>>(
                future: _projectController.fetchAllProjects(),
                builder: (_, AsyncSnapshot<List<ProjectModel>> snapshot) {
                  return (!snapshot.hasData)
                      ? const Center(child: Text('No projects'))
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemBuilder: (_, i) {
                            return snapshot.connectionState ==
                                    ConnectionState.waiting
                                ? ShimmerProjectItem()
                                : ProjectItemWidget(
                                    projectController: _projectController,
                                    model: snapshot.data![i],
                                    // taskLength: snapshot
                                    //     .data![i].tasksNumber,
                                    taskLength: 0,
                                  );
                          });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo2/database/data_source/projects_data_source.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/presentation/pages/menu_pages/floating_button/controller/color_pallete_controller/color_pallete_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/controller/project_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/add_project_button.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_item_widget.dart';
import 'package:todo2/presentation/pages/menu_pages/menu/widgets/project_shimmer_widget.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/presentation/widgets/common/disabled_scroll_glow_widget.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';
void ss(BuildContext context){
context.findAncestorStateOfType<MenuPageState>()!.updateState();
  
}

class MenuPage extends StatefulWidget {
  final VoidCallback? callback;
  const MenuPage({Key? key, this.callback}) : super(key: key);
  static of(BuildContext context, {bool root = false}) => root
      ? context.findRootAncestorStateOfType<MenuPageState>()
      : context.findAncestorStateOfType<MenuPageState>();
 
  @override
  State<MenuPage> createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> { 

void updateState(){
  setState(() {   
  });
}

  late TextEditingController _titleController;
  late ProjectController _projectController;

  StreamController<List<ProjectModel>> streamController = StreamController();
  late StreamSubscription<List<ProjectModel>> streamSubscription;

  List<ProjectModel> list = [];
  Future<void> unbox() async {
    list = await _projectController.fetchAllProjects();
  }


  @override
  void initState() {
    _projectController = ProjectController(
      ProjectRepositoryImpl(
        projectDataSource: ProjectUserDataImpl(
          secureStorageService: SecureStorageSource(),
          network: NetworkSource(),
        ),
      ),
      ColorPalleteController(),
    );
    unbox().then((_) => {
          streamSubscription = streamController.stream.listen((value) {
// print
            log(' ${value.length}');
            setState(() {
              list = value;
            });
          }),
          streamController.add(list),
        });

    _titleController = TextEditingController();

    log('init MenuPage page');
    super.initState();
  }

  @override
  void dispose() {
    _projectController.disposeValues();
    _projectController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.updateState!();
    return AppbarWrapWidget(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: AddProjectButton(
        titleController: _titleController,
        projectController: _projectController,
      ),
      isWhite: false,
      title: 'Projects',
      isRedAppBar: false,
      child: DisabledGlowWidget(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                (list.isEmpty)
                    ? const Center(child: Text('No projects'))
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemBuilder: (_, i) {
                          // log('title : ${snapshot.data![i].title}');
                          return ProjectItemWidget(
                            projectController: _projectController,
                            model: list[i],
                            // taskLength: snapshot
                            //     .data![i].tasksNumber,
                            taskLength: 0,
                          );
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/