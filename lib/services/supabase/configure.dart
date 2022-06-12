
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

Future<void> initSupabase() async {

  try {
    final _configuration = SupabaseConfiguration();
    await Supabase.initialize(
      url: _configuration.supabaseUrl,
      anonKey: _configuration.supabaseAnnonKey,
      debug: true,
      localStorage: SecureLocalStorage(),
    );
  } catch (e) {
    ErrorService.printError('Error in initSupabase: $e');
  }
}

class SecureLocalStorage extends LocalStorage {
  SecureLocalStorage()
      : super(
            initialize: () async {},
            hasAccessToken: () {
              const storage = FlutterSecureStorage();
              return storage.containsKey(key: supabasePersistSessionKey);
            },
            accessToken: () {
              const storage = FlutterSecureStorage();
              return storage.read(key: supabasePersistSessionKey);
            },
            removePersistedSession: () {
              const storage = FlutterSecureStorage();
              return storage.delete(key: supabasePersistSessionKey);
            },
            persistSession: (String value) {
              const storage = FlutterSecureStorage();
              return storage.write(
                  key: supabasePersistSessionKey, value: value);
            });
}
