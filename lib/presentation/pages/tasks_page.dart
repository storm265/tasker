import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo2/presentation/pages/work_list/widgets/app_bar_widget.dart';
import 'package:todo2/presentation/pages/work_list/widgets/blue_circle_widget.dart';


class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late final _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(tabController: _tabController),
        body: TabBarView(controller: _tabController, children: [
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
        ]));
  }
}
