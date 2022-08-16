import 'package:todo2/database/model/auth_model.dart';
import 'package:todo2/database/repository/auth_repository.dart';
import 'package:todo2/services/error_service/error_service.dart';

class RefreshTokenController {
  final AuthRepository _authRepository;
  RefreshTokenController({required AuthRepositoryImpl authRepository})
      : _authRepository = authRepository;

  Future<AuthModel> updateToken() async {
    try {
      final model = await _authRepository.refreshToken();
      return model;
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
