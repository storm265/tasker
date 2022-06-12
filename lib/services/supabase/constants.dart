import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSource {
  static final SupabaseSource _instance = SupabaseSource._internal();

  factory SupabaseSource() {
    return _instance;
  }

  SupabaseSource._internal();

  final SupabaseClient _supabaseClient = Supabase.instance.client;
  SupabaseClient get dbClient => _supabaseClient;


}

// Works nice 
class SupabaseConfiguration {
  SupabaseConfiguration._internal();
  static final SupabaseConfiguration _instance =
      SupabaseConfiguration._internal();
  factory SupabaseConfiguration() {
    return _instance;
  }

  final String _redirectTo = 'io.supabase.todo2://reset-callback';
  String get redirectTo => _redirectTo;

  final String _supabaseUrl = 'https://loaphbqhspenbaeyhaqr.supabase.co';
  String get supabaseUrl => _supabaseUrl;

  final String _supabaseAnnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxvYXBoYnFoc3BlbmJhZXloYXFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTI2Mzc5NTMsImV4cCI6MTk2ODIxMzk1M30.q35gjhnPgLrkaCeyp4yGYNdc5UBY94Ffvq4sqi2np_A';
  String get supabaseAnnonKey => _supabaseAnnonKey;

  final String _publicStorageBaseUrl =
      "https://loaphbqhspenbaeyhaqr.supabase.co/storage/v1/object/sign/avatar/";
  String get publicStorageBaseUrl => _publicStorageBaseUrl;
}
