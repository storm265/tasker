import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/supabase/constants.dart';

class ProfileController extends ChangeNotifier {
  final ProjectRepositoryImpl projectsRepository;
  final UserProfileRepositoryImpl userProfileRepository;
  final AuthRepositoryImpl authRepository;

  ProfileController({
    required this.projectsRepository,
    required this.userProfileRepository,
    required this.authRepository,
  });

  final supabase = SupabaseSource().restApiClient.auth.currentUser;

  late String userName = '';
  late String image = '';
  late String imageStoragePublicUrl = '';
  late AnimationController iconAnimationController;

  Future<void> signOut(BuildContext context) async {
    try {
      final pushBack = NavigationService.navigateTo(context, Pages.welcome);
      final response = await authRepository.signOut(context: context);
      if (response.error != null) {
        MessageService.displaySnackbar(
          context: context,
          message: response.error!.message.toString(),
        );
        pushBack;
      }
    } catch (e) {
      ErrorService.printError('Error in ProfileController  signOut : $e');
    }
  }

  Future<List<ProjectModel>> fetchProject(
      {required BuildContext context}) async {
    try {
      return projectsRepository.fetchProject();
    } catch (e) {
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
      image = await userProfileRepository.fetchAvatar();
      imageStoragePublicUrl =
          await userProfileRepository.fetchAvatarFromStorage(publicUrl: image);
      userName = await userProfileRepository.fetchUserName();
      updateStateCallback();
    } catch (e) {
      ErrorService.printError(
          "Error in ProfileController  fetchProfileInfo() :$e ");
      rethrow;
    }
  }

  Future<String> fetchAvatar() async {
    try {
      final response = await userProfileRepository.fetchAvatar();
      return response;
    } catch (e) {
      ErrorService.printError(
          'Error in UserProfileRepositoryImpl fetchAvatar() : $e');
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
