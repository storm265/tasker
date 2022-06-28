import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';


class TaskListWidget extends StatelessWidget {
  final AsyncSnapshot<List<ProjectModel>> snapshot;
  const TaskListWidget({Key? key,required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: double.infinity,
        height: 110,
        child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) {
                    final data = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 160,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(int.parse(data.color)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          title: Text(
                            data.title,
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
                      ),
                    );
                  })
      ),
    );
  }
}
