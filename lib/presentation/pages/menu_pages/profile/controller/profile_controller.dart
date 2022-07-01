import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/auth/auth_repository.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/user_profile_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/supabase/constants.dart';

class ProfileController extends ChangeNotifier {
  final _projectsRepository = ProjectRepositoryImpl();

  final _authRepository = AuthRepositoryImpl();
  final supabase = SupabaseSource().restApiClient.auth.currentUser;
  final userProfileRepository = UserProfileRepositoryImpl();
  late String userName = '', image = '';
  late AnimationController iconAnimationController;

  Future<void> signOut(BuildContext context) async {
    try {
      final pushBack = NavigationService.navigateTo(context, Pages.welcome);
      await _authRepository.signOut(context: context);
      pushBack;
    } catch (e) {
      ErrorService.printError('Error in signOut() controller: $e');
    }
  }

  Future<List<ProjectModel>> fetchProject() async {
    try {
      return _projectsRepository.fetchProject();
    } catch (e) {
      ErrorService.printError(
          "Error in ProfileController  fetchProfile() :$e ");
      rethrow;
    }
  }

  Future<void> fetchProfileInfo(
      {required VoidCallback updateStateCallback}) async {
    try {
      image = await userProfileRepository.fetchAvatar();
      userName = await userProfileRepository.fetchUserName();
      updateStateCallback();
    } catch (e) {
      ErrorService.printError("Error in ProfileController  getUserData() :$e ");
      rethrow;
    }
  }
  void rotateSettingsIcon({required TickerProvider ticker}){
      iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: ticker,
    )..repeat();
  }
}
