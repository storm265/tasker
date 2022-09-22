import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo2/database/database_scheme/env_scheme.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/database/repository/user_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/navigation_service/navigation_service.dart';
import 'package:todo2/storage/secure_storage_service.dart';

class ProfileController extends ChangeNotifier {
  final SecureStorageSource _secureStorageService;

  final UserProfileRepositoryImpl userProfileRepository;
  final AuthRepositoryImpl authRepository;

  ProfileController({
    required SecureStorageSource secureStorageService,
    required this.userProfileRepository,
    required this.authRepository,
  }) : _secureStorageService = secureStorageService;

  late String username = '';
  late Map<String, String> imageHeader = {};
  final imageUrl = ValueNotifier<String>('');
  late String email = '';
  late AnimationController iconAnimationController;

  Future<void> clearImage() async {
    final url = await _secureStorageService.getUserData(
            type: StorageDataType.avatarUrl) ??
        '';
    await CachedNetworkImage.evictFromCache(url);
    imageUrl.value = url;
    imageUrl.notifyListeners();
  }

  Future<void> fetchProfileInfo() async {
    try {
      imageUrl.value =
          '${dotenv.env[EnvScheme.apiUrl]}/users-avatar/${await getAvatarLink()}';
      imageUrl.notifyListeners();
      imageHeader = await getAvatarHeader();

      email = await _secureStorageService.getUserData(
              type: StorageDataType.email) ??
          '';
      username = await _secureStorageService.getUserData(
              type: StorageDataType.username) ??
          '';
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<String> getAvatarLink() async {
    String avatarLink = await _secureStorageService.getUserData(
          type: StorageDataType.id,
        ) ??
        '';
    return avatarLink;
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
      await _secureStorageService.removeAllUserData();
      await authRepository
          .signOut()
          .then((_) => NavigationService.navigateTo(context, Pages.welcome));
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
