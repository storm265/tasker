import 'package:todo2/database/data_source/user_data_source.dart';



abstract class UserRepository {
  Future<void> insert({
    required String email,
    required String password,
  });
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<void> insert({
    required String password,
    required String email,
  }) async {
    try {
      await UserDataSourceImpl().insert(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }
}
