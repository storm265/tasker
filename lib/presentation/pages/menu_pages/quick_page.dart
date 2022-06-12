import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/appbar_widget.dart';
import 'package:todo2/presentation/widgets/common/colors.dart';

class QuickPage extends StatelessWidget {
  const QuickPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const AppbarWidget(title: 'Quick notes', appBarColor: Colors.white),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: Stack(
                children: [
                  Positioned(
                    top: 1,
                    left: 30,
                    child: SizedBox(
                      width: 121,
                      height: 3,
                      child: ColoredBox(
                        color: colors[0],
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Main title'),
                    subtitle: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            (index == 0)
                                ? Column(
                                    children: [
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: 5,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Checkbox(
                                                    checkColor: Colors.grey,
                                                    activeColor: Colors.grey,
                                                    value: true,
                                                    onChanged: (value) {}),
                                                const Text('adjaidjiad',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough)),
                                              ],
                                            );
                                          }),
                                    ],
                                  )
                                : const Text('Second text dkoakdoaokdoakdka',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        )),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
