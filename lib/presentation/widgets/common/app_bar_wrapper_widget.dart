import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/widgets/common/will_pop_scope_wrapp.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/utils/theme_util.dart';

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

class AppbarWrapWidget extends StatelessWidget  {
  final PreferredSizeWidget? bottom;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget actionWidget;
  final Widget child;
  final String? title;
  final bool showLeadingButton;
  final bool showAppBar;
  final bool isRedAppBar;
  final double preferredHeight;
  final bool? isWhite;
  final bool? isPopFromNavBar;
  final bool isCustomRoute;
  final Pages navRoute;
  final bool? resizeToAvoidBottomInset;
  const AppbarWrapWidget({
    Key? key,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    required this.child,
    this.preferredHeight = 60,
    this.bottom,
    this.title,
    this.actionWidget = const SizedBox(),
    this.showLeadingButton = false,
    this.showAppBar = true,
    this.isRedAppBar = true,
    this.isWhite,
    this.isPopFromNavBar,
    this.isCustomRoute = false,
    this.navRoute = Pages.tasks,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);


  Size get preferredSize => Size(double.infinity, preferredHeight);

  @override
  Widget build(BuildContext context) {
    final navigationController =
        NavigationInherited.of(context).navigationController;
    return WillPopWrap(
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        backgroundColor:
            isWhite == null ? Colors.white : const Color(0xffFDFDFD),
        appBar: showAppBar
            ? AppBar(
                systemOverlayStyle: isRedAppBar ? _redBar : _whiteBar,
                elevation: 0,
                backgroundColor: isRedAppBar ? Palette.red : Colors.white,
                leading: showLeadingButton
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          onTap: () async {
                            if (!isCustomRoute) {
                              if (isPopFromNavBar == true) {
                                FocusScope.of(context).unfocus();
                                await navigationController.moveToPage(navRoute);
                              } else {
                                Navigator.pop(context);
                              }
                            } else {
                              
                          await     NavigationService.navigateTo(context, navRoute);
                            }
                          },
                          child: Icon(
                            Icons.west_rounded,
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
                    fontWeight: FontWeight.w200,
                  ),
                ),
                actions: [actionWidget],
                bottom: bottom,
              )
            : null,
        body: SafeArea(
          maintainBottomViewPadding: true,
          bottom: false,
          child: child,
        ),
      ),
    );
  }
}
