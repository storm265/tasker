import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/presentation/work_list/widgets/app_bar_widget.dart';
import 'package:todo2/presentation/work_list/navigation_page.dart';
import 'package:todo2/presentation/work_list/widgets/blue_circle_widget.dart';

class TasksPage extends StatelessWidget {
  final TabController tabController;
  const TasksPage({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(tabController: tabController),
      body: TabBarView(controller: tabController, children: [
        ListView.builder(
          itemBuilder: ((context, index) {
            return Column(
              children: [
                Text('dadiadhjiajdad '),
                Slidable(
                    key: ValueKey(0),
                    endActionPane: const ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                            flex: 2,
                            onPressed: null,
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Archive'),
                        SlidableAction(
                            onPressed: null,
                            backgroundColor: Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: 'Save')
                      ],
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                            elevation: 5,
                            child: ListTile(
                                leading: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CustomPaint(
                                      size: Size(20, 20),
                                      painter: CirclePainter(),
                                    )),
                                trailing: SizedBox(
                                    width: 5,
                                    height: 25,
                                    child: ColoredBox(color: Colors.blue)),
                                subtitle: Text('Slide me'),
                                title: Text('Slide me')))))
              ],
            );
          }),
        ),
        Column(children: const [Text('dadiadhjiajdad ')])
      ]),
    );
  }
}
