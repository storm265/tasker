
import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class UserRepository {
  Future<void> insertUser({
    required String email,
    required String password,
  });
}

class UserRepositoryImpl implements UserRepository {
  final _userRepository = UserDataSourceImpl();
  @override
  Future<void> insertUser({
    required String password,
    required String email,
  }) async {
    try {
      await _userRepository.insert(
        email: email,
        password: password,
      );
    } catch (e) {
      ErrorService.printError('Error in insert() UserRepositoryImpl: $e');
      rethrow;
    }
  }
}
