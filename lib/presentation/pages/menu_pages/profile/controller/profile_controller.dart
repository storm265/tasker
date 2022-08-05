import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/message_service/message_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class ProfileController extends ChangeNotifier {
  final SecureStorageService tokenStorageService;
  final ProjectRepositoryImpl projectsRepository;
  final UserProfileRepositoryImpl userProfileRepository;
  final AuthRepositoryImpl authRepository;

  ProfileController({
    required this.projectsRepository,
    required this.userProfileRepository,
    required this.authRepository,
    required this.tokenStorageService,
  });

  late String userName = '';
  late String image = '';
  late String imageStoragePublicUrl = '';
  late AnimationController iconAnimationController;

  Future<void> signOut({required BuildContext context}) async {
    try {
      final response = await authRepository.signOut();
      if (response.statusCode != 200) {
        MessageService.displaySnackbar(
          message: '${response.statusMessage}',
        );
      } else {
        await tokenStorageService.removeAllUserData();
        await Future.delayed(
          Duration.zero,
          () async => NavigationService.navigateTo(context, Pages.welcome),
        );
      }
    } catch (e) {
      ErrorService.printError('Error in ProfileController  signOut : $e');
    }
  }

  Future<Map<String, dynamic>> fetchProject() async {
    try {
      final response = await projectsRepository.fetchOneProject();
      return response;
    } catch (e) {
      ErrorService.printError(
          "Error in ProfileController  fetchProject() :$e ");
      rethrow;
    }
  }

  // Future<void> fetchProfileInfo({
  //   required VoidCallback updateStateCallback,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     image = await userProfileRepository.fetchAvatar();
  //     imageStoragePublicUrl =
  //         await userProfileRepository.fetchAvatarFromStorage(publicUrl: image);
  //     userName = '';
  //     // await userProfileRepository.fetchUserName();
  //     updateStateCallback();
  //   } catch (e) {
  //     ErrorService.printError(
  //         "Error in ProfileController  fetchProfileInfo() :$e ");
  //     rethrow;
  //   }
  // }

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
