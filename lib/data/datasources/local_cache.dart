/// In-Memory & Local Storage Cache with Time-To-Live (TTL) eviction.
class CacheItem<T> {
  final T data;
  final DateTime expiresAt;

  CacheItem(this.data, Duration ttl) : expiresAt = DateTime.now().add(ttl);

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

class LocalCacheDataSource {
  final Map<String, CacheItem<dynamic>> _store = {};

  void put<T>(String key, T value, {Duration ttl = const Duration(minutes: 15)}) {
    _store[key] = CacheItem<T>(value, ttl);
  }

  T? get<T>(String key) {
    final entry = _store[key];
    if (entry == null) return null;
    if (entry.isExpired) {
      _store.remove(key);
      return null;
    }
    return entry.data as T?;
  }

  void invalidate(String key) => _store.remove(key);
  void clear() => _store.clear();
  int get activeEntriesCount => _store.length;
}
