import 'package:flutter/material.dart';


class AppbarWidget extends StatelessWidget with PreferredSizeWidget {
  final String title;
  const AppbarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, 50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w300)),
        backgroundColor: Colors.white,
        elevation: 0);
  }
}
