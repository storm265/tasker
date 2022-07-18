import 'package:todo2/database/data_source/user_data_source.dart';
import 'package:todo2/database/database_scheme/user_profile_scheme.dart';
import 'package:todo2/database/model/users_profile_model.dart';
import 'package:todo2/services/error_service/error_service.dart';

abstract class UserRepository {
  Future<void> postUser({
    required String email,
    required String password,
  });
  Future<void> fetchUser();
  Future fetchEmail();
}

class UserRepositoryImpl implements UserRepository {
  final _userRepository = UserDataSourceImpl();
  @override
  Future<void> postUser({
    required String password,
    required String email,
  }) async {
    try {
      await _userRepository.postUser(
        email: email,
        password: password,
      );
    } catch (e) {
      ErrorService.printError('Error in UserRepositoryImpl insert() : $e');
      rethrow;
    }
  }

  @override
  Future<List<UserProfileModel>> fetchUser() async {
    try {
      final response = await _userRepository.fetchUser();
      return (response.data as List<dynamic>)
          .map((json) => UserProfileModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorService.printError('Error in insert() UserRepositoryImpl: $e');
      rethrow;
    }
  }

  @override
  Future<List<String>> fetchEmail() async {
    try {
      List<String> emails = [];
      final response = await _userRepository.fetchEmail();
      for (var i = 0; i < response.data.length; i++) {
        emails.add(response.data[i][UserProfileScheme.email] as String);
      }
      return emails;
    } catch (e) {
      ErrorService.printError(
          'Error in fetchEmail() UserProfileRepositoryImpl: $e');
      rethrow;
    }
  }
}
