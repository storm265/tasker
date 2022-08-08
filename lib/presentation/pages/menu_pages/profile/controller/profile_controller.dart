import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';
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

  Future<void> signOut() async {
    await authRepository.signOut();
  }

  Future<BaseListResponse<ProjectModel>> fetchProject() async {
    final response = await projectsRepository.fetchOneProject();
    return response;
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
    final response = await userProfileRepository.downloadAvatar();
    return response;
  }

  void rotateSettingsIcon({required TickerProvider ticker}) {
    iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: ticker,
    )..repeat();
  }
}
