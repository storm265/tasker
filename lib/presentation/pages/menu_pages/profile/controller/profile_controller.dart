import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/auth/auth_repository.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/supabase/constants.dart';

class ProfileController extends ChangeNotifier {
  final _projectsRepository = ProjectRepositoryImpl();
  final _userProfileRepository = UserProfileRepositoryImpl();
  final _authRepository = AuthRepositoryImpl();

  final supabase = SupabaseSource().restApiClient.auth.currentUser;

  late String userName = '', image = '';
  late AnimationController iconAnimationController;

  Future<void> signOut(BuildContext context) async {
    try {
      final pushBack = NavigationService.navigateTo(context, Pages.welcome);
      await _authRepository.signOut(context: context);
      pushBack;
    } catch (e) {
      MessageService.displaySnackbar(
          context: context,
          message: 'Error in ProfileController  signOut : $e');
      ErrorService.printError('Error in ProfileController  signOut : $e');
    }
  }

  Future<List<ProjectModel>> fetchProject(
      {required BuildContext context}) async {
    try {
      return _projectsRepository.fetchProject();
    } catch (e) {
      MessageService.displaySnackbar(
        context: context,
        message: "Error in ProfileController  fetchProject() :$e ",
      );
      ErrorService.printError(
          "Error in ProfileController  fetchProject() :$e ");
      rethrow;
    }
  }

  Future<void> fetchProfileInfo({
    required VoidCallback updateStateCallback,
    required BuildContext context,
  }) async {
    try {
      image = await _userProfileRepository.fetchAvatar();
      userName = await _userProfileRepository.fetchUserName();
      updateStateCallback();
    } catch (e) {
      MessageService.displaySnackbar(
        context: context,
        message: "Error in ProfileController  fetchProfileInfo() :$e ",
      );
      ErrorService.printError(
          "Error in ProfileController  fetchProfileInfo() :$e ");
      rethrow;
    }
  }

  void rotateSettingsIcon({required TickerProvider ticker}) {
    iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: ticker,
    )..repeat();
  }
}
