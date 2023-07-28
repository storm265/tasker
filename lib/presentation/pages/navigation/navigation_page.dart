import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/generated/locale_keys.g.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_status.dart';
import 'package:todo2/presentation/pages/navigation/floating_button_widget.dart';
import 'package:todo2/presentation/pages/navigation/nav_bar_item_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/status_bar_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

const _greyColor = Color(0xff8E8E93);

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBarController =
        InheritedStatusBar.of(context).statusBarController;
    final navigationController =
        NavigationInherited.of(context).navigationController;
    return ValueListenableBuilder(
        valueListenable: statusBarController.statusBarStatus,
        builder: (context, statusBarStatus, _) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: getStatusBarColor(statusBarStatus),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButton: const FloatingButtonWidget(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: SafeArea(
                maintainBottomViewPadding: true,
                bottom: false,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: navigationController.pages.length,
                  controller: navigationController.pageController,
                  itemBuilder: (_, i) => navigationController.pages[i],
                  onPageChanged: (index) {
                    switch (index) {
                      case 0:
                        statusBarController
                            .setStatusModeColor(StatusBarColors.red);
                        break;
                      case 1:
                        statusBarController
                            .setStatusModeColor(StatusBarColors.white);
                        break;
                      case 2:
                        statusBarController
                            .setStatusModeColor(StatusBarColors.white);
                        break;
                      case 3:
                        statusBarController
                            .setStatusModeColor(StatusBarColors.white);
                        break;
                      case 4:
                        statusBarController
                            .setStatusModeColor(StatusBarColors.red);
                        break;
                      case 5:
                        statusBarController
                            .setStatusModeColor(StatusBarColors.red);
                        break;
                      case 6:
                        statusBarController
                            .setStatusModeColor(StatusBarColors.red);
                        break;
                      case 7:
                        statusBarController
                            .setStatusModeColor(StatusBarColors.blue);
                        break;
                    }
                  },
                ),
              ),
              bottomNavigationBar: ValueListenableBuilder<int>(
                  valueListenable: navigationController.pageIndex,
                  builder: (__, pageIndex, _) {
                    return Container(
                      height: 60,
                      width: double.infinity,
                      color: const Color(0xFF292E4E),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NavBarItemWidget(
                            onTap: () async => await navigationController
                                .moveToPage(Pages.tasks),
                            label: LocaleKeys.my_tasks.tr(),
                            icon: 'tasks',
                            iconColor:
                                pageIndex == 0 ? Colors.white : _greyColor,
                          ),
                          NavBarItemWidget(
                            onTap: () async => await navigationController
                                .moveToPage(Pages.menu),
                            label: LocaleKeys.menu.tr(),
                            icon: 'menu',
                            iconColor: pageIndex == 1 || pageIndex == 7
                                ? Colors.white
                                : _greyColor,
                          ),
                          const SizedBox(width: 50),
                          NavBarItemWidget(
                            onTap: () async => await navigationController
                                .moveToPage(Pages.quick),
                            label: LocaleKeys.quick.tr(),
                            icon: 'quick',
                            iconColor: pageIndex == 2 ||
                                    pageIndex == 6 ||
                                    pageIndex == 5
                                ? Colors.white
                                : _greyColor,
                          ),
                          NavBarItemWidget(
                            onTap: () async => await navigationController
                                .moveToPage(Pages.profile),
                            label: LocaleKeys.profile.tr(),
                            icon: 'profile',
                            iconColor:
                                pageIndex == 3 ? Colors.white : _greyColor,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
