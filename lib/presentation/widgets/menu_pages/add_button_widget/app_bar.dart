import 'package:flutter/material.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';
import 'package:todo2/presentation/pages/navigation_page.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  const AppBarCustom({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () => pageController.jumpToPage(0),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(width: 60),
          ],
        ),
      ),
      width: double.infinity,
      height: 150,
      color: Palette.red,
    );
  }
}
