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


    Future<void> signOut(BuildContext context) async {
    try {
      await _authRepository.signOut(context: context);
      NavigationService.navigateTo(context, Pages.welcome);
    } catch (e) {
      ErrorService.printError('Error in signOut() controller: $e');
    }
  }

  Future<List<ProjectModel>> fetchProfile() async {
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
}
