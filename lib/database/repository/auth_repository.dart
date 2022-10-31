import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/database/model/auth_model.dart';

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

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthDataSource authDataSource})
      : _authDataSource = authDataSource;
  final AuthDataSource _authDataSource;

  @override
  Future<AuthModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _authDataSource.signIn(
      email: email,
      password: password,
    );
    return AuthModel.fromJson(json: response);
  }

  @override
  Future<AuthModel> signUp({
    required String email,
    required String password,
    required String nickname,
  }) async {
    final response = await _authDataSource.signUp(
      email: email,
      password: password,
      nickname: nickname,
    );
    return AuthModel.fromJson(
      json: response,
      isSignUp: true,
    );
  }

  @override
  Future<AuthModel> refreshToken() async {
    final response = await _authDataSource.refreshToken();
    return AuthModel.fromJson(json: response);
  }

  @override
  Future<void> signOut() async => await _authDataSource.signOut();
}
