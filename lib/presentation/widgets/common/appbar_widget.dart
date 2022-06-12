import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';

class AppbarWidget extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Color appBarColor;
  final bool showLeadingButton;

  const AppbarWidget(
      {Key? key,
      this.title,
      this.showLeadingButton = false,
      this.appBarColor = Palette.red})
      : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, 60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: appBarColor,
          systemNavigationBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark),
      leading: showLeadingButton
          ? Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            )
          : const SizedBox(),
      centerTitle: true,
      title: Text(
        title ?? '',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      ),
      elevation: 0,
    );
  }
}
