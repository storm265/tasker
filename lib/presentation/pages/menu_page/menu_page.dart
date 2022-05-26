import 'package:flutter/material.dart';
import 'package:todo2/presentation/appbar_widget.dart';
import 'package:todo2/presentation/pages/menu_page/add_project_button.dart';
import 'package:todo2/presentation/pages/menu_page/category_length_widget.dart';
import 'package:todo2/presentation/pages/menu_page/category_widget.dart';
import 'package:todo2/presentation/pages/menu_page/circle_widget.dart';



class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppbarWidget(title: 'Projects'),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0),
                  itemBuilder: (BuildContext context, index) {
                    return Container(
                        width: 140,
                        height: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Stack(children: const [
                          CircleWidget(),
                          CategoryWidget(),
                          CategoryLengthWidget(),
                        ]));
                  }),
              const AddProjectButton()
            ])));
  }
}
