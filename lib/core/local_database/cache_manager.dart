class CacheManager {
  /// 24 hour cache duration
  static const int cacheDuration = 24 * 60 * 60 * 1000;

  bool isCacheExpired(int cacheTimestamp) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    return currentTime - cacheTimestamp > cacheDuration;
  }
}
