// ignore_for_file: prefer_final_fields

import 'package:todo2/services/cache_service/cache_keys.dart';

class InMemoryCache {
  static final InMemoryCache _instance = InMemoryCache._internal();

  factory InMemoryCache() {
    return _instance;
  }
  InMemoryCache._internal();

  final _defaultMinutes = 1;

  Map<String, DateTime?> _lastFetched = {
    CacheKeys.tasks.type: null,
    CacheKeys.menu.type: null,
    CacheKeys.quick.type: null,
  };

  void updateCacheKey({
    required CacheKeys key,
    required DateTime date,
  }) =>
      _lastFetched[key.type] = date;

  bool shouldFetchOnlineData({
    required CacheKeys key,
    required DateTime date,
    bool isSaveKey = true,
  }) {
    if (_lastFetched[key.type] == null ||
        (_lastFetched[key.type] != null &&
            DateTime.now().difference(_lastFetched[key.type]!).inMinutes >=
                _defaultMinutes)) {
      isSaveKey ? updateCacheKey(key: key, date: date) : null;
      return true;
    } else {
      return false;
    }
  }
}
