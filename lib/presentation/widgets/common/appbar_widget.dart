import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';
import 'package:todo2/presentation/pages/navigation_page.dart';

class AppbarWidget extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Color appBarColor;
  final Color textColor;
  final bool shouldUsePopMethod;
  final bool showLeadingButton;
  final Brightness brightness;
  const AppbarWidget({
    Key? key,
    this.title,
    this.shouldUsePopMethod = false,
    this.showLeadingButton = false,
    this.textColor = Colors.black,
    this.appBarColor = Palette.red,
    this.brightness = Brightness.light,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, 60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: appBarColor,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: brightness,
      ),
      leading: showLeadingButton
          ? Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () => shouldUsePopMethod
                    ? Navigator.pop(context)
                    : pageController.jumpToPage(0),
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
          fontStyle: FontStyle.italic,
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
