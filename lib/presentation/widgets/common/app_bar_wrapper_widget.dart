import 'package:flutter/material.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/inherited_navigation_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

class AppbarWrapperWidget extends StatelessWidget with PreferredSizeWidget {
  final Widget child;
  final String? title;
  final Color appBarColor;
  final Color titleColor;
  final bool shouldUsePopMethod;
  final bool showLeadingButton;
  final bool showAppBar;

  const AppbarWrapperWidget({
    Key? key,
    required this.child,
    this.title,
    this.shouldUsePopMethod = false,
    this.showLeadingButton = false,
    this.showAppBar = true,
    this.titleColor = Colors.black,
    this.appBarColor = Palette.red,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size(double.infinity, 60);

  @override
  Widget build(BuildContext context) {
    final inheritedNavigatorConroller =
        InheritedNavigator.of(context)!.navigationController;

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              elevation: 0,
              backgroundColor: appBarColor,
              leading: showLeadingButton
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () => shouldUsePopMethod
                            ? Navigator.pop(context)
                            : inheritedNavigatorConroller
                                .animateToPage(NavigationPages.tasks),
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: titleColor,
                        ),
                      ),
                    )
                  : const SizedBox(),
              centerTitle: true,
              title: Text(
                title ?? '',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: titleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          : null,
      body: SafeArea(child: child),
    );
  }
}
