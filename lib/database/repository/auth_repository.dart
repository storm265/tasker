import 'package:todo2/database/data_source/auth_data_source.dart';
import 'package:todo2/database/model/auth_model.dart';
import 'package:todo2/services/network_service/base_response/base_response.dart';
import 'package:todo2/services/storage/secure_storage_service.dart';

abstract class AuthRepository {
  Future<BaseResponse<AuthModel>> signUp({
    required String email,
    required String password,
    required String nickname,
  });

  Future<BaseResponse<AuthModel>> signIn({
    required String email,
    required String password,
  });

  Future<void>  signOut();
  Future<String> refreshToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final _authDataSource = AuthDataSourceImpl(
    secureStorageService: SecureStorageService(),
  );

  @override
  Future<BaseResponse<AuthModel>> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _authDataSource.signIn(
      email: email,
      password: password,
    );
    return response;
  }

  @override
  Future<BaseResponse<AuthModel>> signUp({
    required String email,
    required String password,
    required String nickname,
  }) async {
    final response = await _authDataSource.signUp(
      email: email,
      password: password,
      nickname: nickname,
    );
    return response;
  }

  @override
  Future<void> signOut() async {
     await _authDataSource.signOut();

  }

  @override
  Future<String> refreshToken() async {
    final response = await _authDataSource.refreshToken();
    return response.model.refreshToken;
  }
}
