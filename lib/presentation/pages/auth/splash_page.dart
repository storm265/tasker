import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo2/presentation/widgets/common/app_bar_wrapper_widget.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/secure_storage_service.dart';
import 'package:todo2/utils/assets_path.dart';

String? locale;

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final _secureStorageService = SecureStorageSource();

  Future<void> isAuthenticated(BuildContext context) async {
    final accessToken = await _secureStorageService.getUserData(
        type: StorageDataType.accessToken);
    await Future.delayed(
      const Duration(seconds: 0),
      () async => await NavigationService.navigateTo(
        context,
        accessToken == null ? Pages.welcome : Pages.navigationReplacement,
      ),
    );
  }

  Future<void> setLocale(BuildContext context) async {
    locale = context.locale.languageCode;
    log('locale $locale');
    Intl.withLocale(locale, () => null);
  }

  @override
  Widget build(BuildContext context) {
    isAuthenticated(context);
    setLocale(context);
    return AppbarWrapWidget(
      isRedAppBar: false,
      child: Center(
        child: Image.asset(AssetsPath.splashPath),
      ),
    );
  }
}
