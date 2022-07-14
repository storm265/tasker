import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/inherited_navigation_controller.dart';
import 'package:todo2/presentation/pages/menu_pages/navigation/controllers/navigation_controller.dart';
import 'package:todo2/services/theme_service/theme_data_controller.dart';

const _whiteBar = SystemUiOverlayStyle(
  statusBarColor: Colors.white,
  // For Android.
  statusBarIconBrightness: Brightness.dark,
  // For iOS.
  statusBarBrightness: Brightness.dark,
);

const _redBar = SystemUiOverlayStyle(
  statusBarColor: Palette.red,
  // For Android.
  statusBarIconBrightness: Brightness.light,
  // For iOS.
  statusBarBrightness: Brightness.light,
);

class AppbarWrapperWidget extends StatelessWidget with PreferredSizeWidget {
  final Widget child;
  final String? title;
  final bool shouldUsePopMethod;
  final bool showLeadingButton;
  final bool showAppBar;
  final bool isRedAppBar;

  const AppbarWrapperWidget({
    Key? key,
    required this.child,
    this.title,
    this.shouldUsePopMethod = false,
    this.showLeadingButton = false,
    this.showAppBar = true,
    this.isRedAppBar = true,
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
              systemOverlayStyle: isRedAppBar ? _redBar : _whiteBar,
              elevation: 0,
              backgroundColor: isRedAppBar ? Palette.red : Colors.white,
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
                          color: isRedAppBar ? Colors.white : Colors.black,
                        ),
                      ),
                    )
                  : const SizedBox(),
              centerTitle: true,
              title: Text(
                title ?? '',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: isRedAppBar ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          : null,
      body: SafeArea(
        maintainBottomViewPadding: true,
        bottom: false,
        child: child,
      ),
    );
  }
}
