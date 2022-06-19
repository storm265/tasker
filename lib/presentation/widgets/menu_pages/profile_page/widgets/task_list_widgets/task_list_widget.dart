import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/projects_repository.dart';


class TaskListWidget extends StatelessWidget {
  TaskListWidget({Key? key}) : super(key: key);
  final _projectsRepository = ProjectRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: double.infinity,
        height: 110,
        child: FutureBuilder<List<ProjectModel>>(
          future: _projectsRepository.fetchProject(),
          builder: (_, AsyncSnapshot<List<ProjectModel>> snapshot) {
            if (snapshot.data == null) {
              return const CircularProgressIndicator();
            }
            if (snapshot.data!.isEmpty) {
              return const SizedBox();
            } else if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 160,
                        height: 100,
                        child: ListTile(
                          title: Text(
                            snapshot.data![index].title ?? 'null',
                            style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: const Text(
                            '12 tasks',
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(int.parse(snapshot.data![index].color!)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  });
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
