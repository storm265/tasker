// ignore_for_file: prefer_final_fields

enum CacheKeys {
  tasks('tasks'),
  menu('menu'),
  quick('quick');

  final String type;
  const CacheKeys(this.type);
}

class InMemoryCache {
  static final InMemoryCache _instance = InMemoryCache._internal();

  factory InMemoryCache() {
    return _instance;
  }
  InMemoryCache._internal();

  final _defaultMinutes = 2;

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
  }) {
    if (_lastFetched[key.type] == null ||
        (_lastFetched[key.type] != null &&
            DateTime.now().difference(_lastFetched[key.type]!).inMinutes >=
                _defaultMinutes)) {
      updateCacheKey(key: key, date: date);
      return true;
    } else {
      return false;
    }
  }
}
