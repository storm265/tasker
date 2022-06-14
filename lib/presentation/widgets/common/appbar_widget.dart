import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/controller/main/theme_data_controller.dart';

class AppbarWidget extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Color appBarColor;
  final Color textColor;
  final bool showLeadingButton;

  const AppbarWidget({
    Key? key,
    this.title,
    this.showLeadingButton = false,
    this.textColor = Colors.black,
    this.appBarColor = Palette.red,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, 60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: appBarColor,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
      leading: showLeadingButton
          ? Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: textColor,
                ),
              ),
            )
          : const SizedBox(),
      centerTitle: true,
      title: Text(
        title ?? '',
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      ),
      elevation: 0,
    );
  }
}
