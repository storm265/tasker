import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSource {
  static final SupabaseSource _instance = SupabaseSource._internal();

  factory SupabaseSource() {
    return _instance;
  }

  SupabaseSource._internal();

  final SupabaseClient _supabaseClient = Supabase.instance.client;
  SupabaseClient get restApiClient => _supabaseClient;
}

class SupabaseConfiguration {
  final String redirectTo = 'io.supabase.todo2://reset-callback';
  final String supabaseUrl = 'https://loaphbqhspenbaeyhaqr.supabase.co';

  final String supabaseAnnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxvYXBoYnFoc3BlbmJhZXloYXFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTI2Mzc5NTMsImV4cCI6MTk2ODIxMzk1M30.q35gjhnPgLrkaCeyp4yGYNdc5UBY94Ffvq4sqi2np_A';

  final String publicStorageBaseUrl =
      "https://loaphbqhspenbaeyhaqr.supabase.co/storage/v1/object/sign/avatar/";
}
