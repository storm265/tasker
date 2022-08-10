import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo2/database/model/projects_model.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/projects_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

class ProfileController extends ChangeNotifier {
  final SecureStorageService _secureStorageService;
  final SecureStorageService tokenStorageService;
  final ProjectRepositoryImpl projectsRepository;
  final UserProfileRepositoryImpl userProfileRepository;
  final AuthRepositoryImpl authRepository;

  ProfileController({
    required SecureStorageService secureStorageService,
    required this.projectsRepository,
    required this.userProfileRepository,
    required this.authRepository,
    required this.tokenStorageService,
  }) : _secureStorageService = secureStorageService;

  late String username='';
  late String image='';
  late String email='';
  late AnimationController iconAnimationController;

  Future<void> signOut({required BuildContext context}) async {
    await authRepository
        .signOut()
        .then((_) => NavigationService.navigateTo(context, Pages.welcome));
  }

  Future<BaseListResponse<ProjectModel>> fetchProject() async {
    final response = await projectsRepository.fetchOneProject();
    return response;
  }

  Future<void> fetchProfileInfo(
      {required VoidCallback updateStateCallback}) async {
    try {
      image = await userProfileRepository.downloadAvatar();
      email = await _secureStorageService.getUserData(
              type: StorageDataType.email) ??
          '';
      username = await _secureStorageService.getUserData(
              type: StorageDataType.username) ??
          '';

      updateStateCallback();
    } catch (e) {
      ErrorService.printError(
          "Error in ProfileController  fetchProfileInfo() :$e ");
      rethrow;
    }
  }

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
