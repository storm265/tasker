import 'dart:developer';

import 'package:todo2/services/error_service/error_service.dart';
import 'package:todo2/services/supabase/constants.dart';

Future<void> updateToken() async {
  try {
    final supabase = SupabaseSource().restApiClient.auth;
    final expiresAt = DateTime.fromMillisecondsSinceEpoch(
        supabase.currentSession!.expiresAt! * 1000);

    log('Time now: ${DateTime.now()}');
    log('expiresAt: $expiresAt');
    if (DateTime.now().isAfter(expiresAt)) {
      log('*** Updating token *** ');
        await supabase.refreshSession();
      log('*** Token updated *** ');
    }
  } catch (e) {
    ErrorService.printError('Update token error $e');
  }
}
