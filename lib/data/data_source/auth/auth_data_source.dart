
abstract class AuthDataSource {
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String nickname,
  });
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<Map<String, dynamic>> refreshToken();
}
