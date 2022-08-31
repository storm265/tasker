import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_navigator.dart';
import 'package:todo2/presentation/pages/navigation/controllers/inherited_status.dart';
import 'package:todo2/presentation/pages/navigation/floating_button_widget.dart';
import 'package:todo2/presentation/pages/navigation/nav_bar_widget.dart';
import 'package:todo2/presentation/pages/navigation/controllers/status_bar_controller.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({Key? key}) : super(key: key);

  final _greyColor = const Color(0xff8E8E93);

  @override
  Widget build(BuildContext context) {
    final statusBarController =
        InheritedStatusBar.of(context).statusBarController;
    final navigationController =
        NavigationInherited.of(context).navigationController;
    return ValueListenableBuilder(
        valueListenable: statusBarController.isRedStatusBar,
        builder: (context, isRed, _) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: (isRed == true) ? redStatusBar : lightStatusBar,
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
                    onPageChanged: (index) {
                      log('index $index');
                      navigationController.pages[index];
                      switch (index) {
                        case 0:
                          statusBarController.setRedStatusMode(true);
                          break;
                        case 1:
                          statusBarController.setRedStatusMode(false);
                          break;
                        case 2:
                          statusBarController.setRedStatusMode(false);
                          break;
                        case 3:
                          statusBarController.setRedStatusMode(false);
                          break;
                        case 4:
                          statusBarController.setRedStatusMode(true);
                          break;
                        case 5:
                          statusBarController.setRedStatusMode(true);
                          break;
                        case 6:
                          statusBarController.setRedStatusMode(true);
                          break;
                        default:
                      }
                    },
                    itemBuilder: (_, i) => navigationController.pages[i]),
              ),
              bottomNavigationBar: ValueListenableBuilder<int>(
                  valueListenable: navigationController.pageIndex,
                  builder: (__, pageIndex, _) {
                    log('page index $pageIndex');
                    return Container(
                      height: 60,
                      width: double.infinity,
                      color: const Color(0xFF292E4E),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NavBarItem(
                            onTap: () async => await navigationController
                                .moveToPage(Pages.tasks),
                            label: 'My Tasks',
                            icon: 'tasks',
                            iconColor:
                                pageIndex == 0 ? Colors.white : _greyColor,
                          ),
                          NavBarItem(
                            onTap: () async => await navigationController
                                .moveToPage(Pages.menu),
                            label: 'Menu',
                            icon: 'menu',
                            iconColor:
                                pageIndex == 1 ? Colors.white : _greyColor,
                          ),
                          const SizedBox(width: 50),
                          NavBarItem(
                            onTap: () async => await navigationController
                                .moveToPage(Pages.quick),
                            label: 'Quick',
                            icon: 'quick',
                            iconColor:
                                pageIndex == 2 ? Colors.white : _greyColor,
                          ),
                          NavBarItem(
                            onTap: () async => await navigationController
                                .moveToPage(Pages.profile),
                            label: 'Profile',
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
