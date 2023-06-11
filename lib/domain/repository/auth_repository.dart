
import 'package:todo2/domain/model/auth_model.dart';

abstract class AuthRepository {
  Future<AuthModel> signUp({
    required String email,
    required String password,
    required String nickname,
  });

  Future<AuthModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
  Future<AuthModel> refreshToken();
}
