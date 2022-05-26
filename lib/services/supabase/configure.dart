import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://loaphbqhspenbaeyhaqr.supabase.co';
const supabaseAnnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxvYXBoYnFoc3BlbmJhZXloYXFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTI2Mzc5NTMsImV4cCI6MTk2ODIxMzk1M30.q35gjhnPgLrkaCeyp4yGYNdc5UBY94Ffvq4sqi2np_A';
final supabase = Supabase.instance.client;
Future initSupabase() async {
  await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnnonKey,
      authCallbackUrlHostname: 'login-callback',
      debug: true,
      localStorage: SecureLocalStorage());
}

// user flutter_secure_storage to persist user session
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
