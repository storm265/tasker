import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/model/supabase/user_model.dart';
import 'package:todo2/services/error_service/error_service.dart';


abstract class UserRepository<T> {
  Future<void> insert({
    required String email,
    required String password,
  });
}

class UserRepositoryImpl implements UserRepository<User> {
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
      ErrorService.printError('Error in insert() UserRepositoryImpl: $e');
    }
  }
}
