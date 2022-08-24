import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo2/database/database_scheme/env_scheme.dart';
import 'package:todo2/database/model/project_models/project_stats_model.dart';
import 'package:todo2/database/model/project_models/projects_model.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/services/network_service/network_config.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class ProfileController extends ChangeNotifier {
  final SecureStorageService _secureStorageService;
  final SecureStorageService tokenStorageService;

  final UserProfileRepositoryImpl userProfileRepository;
  final AuthRepositoryImpl authRepository;

  ProfileController({
    required SecureStorageService secureStorageService,
    required this.userProfileRepository,
    required this.authRepository,
    required this.tokenStorageService,
  }) : _secureStorageService = secureStorageService;

  late String username = '';
  late Map<String, String> imageHeader = {};
  late String imageUrl = '';
  late String email = '';
  late AnimationController iconAnimationController;

  // Future<ProjectModel> fetchProject() async {
  //   final response = await projectsRepository.fetchOneProject();
  //   return response;
  // }

  Future<void> fetchProfileInfo(
      {required VoidCallback updateStateCallback}) async {
    try {
      log('header: $imageHeader');
      log('header: $imageUrl');
      String? ava = await getAvatarLink();
      imageUrl = '${dotenv.env[EnvScheme.apiUrl]}/users-avatar/${ava!}';
      final map = await getAvatarHeader();
      imageHeader = map;

      email = await _secureStorageService.getUserData(
              type: StorageDataType.email) ??
          '';
      username = await _secureStorageService.getUserData(
              type: StorageDataType.username) ??
          '';

      updateStateCallback();
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<String?> getAvatarLink() async {
    return _secureStorageService.getUserData(
      type: StorageDataType.id,
    );
  }

  Future<Map<String, String>> getAvatarHeader() async {
    return {
      'Authorization':
          'Bearer ${await _secureStorageService.getUserData(type: StorageDataType.accessToken)}',
    };
  }

  void rotateSettingsIcon({required TickerProvider ticker}) {
    iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: ticker,
    )..repeat();
  }

  Future<void> signOut({required BuildContext context}) async {
    try {
      await authRepository
          .signOut()
          .then((_) => NavigationService.navigateTo(context, Pages.welcome));
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
