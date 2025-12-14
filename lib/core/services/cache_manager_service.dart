/// Cache manager service for reducing redundant API calls
library cache_manager_service;

import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Cache entry with metadata
class CacheEntry<T> {
  final T data;
  final DateTime timestamp;
  final Duration ttl;

  CacheEntry({
    required this.data,
    required this.timestamp,
    required this.ttl,
  });

  bool get isExpired => DateTime.now().difference(timestamp) > ttl;

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'ttl': ttl.inMilliseconds,
  };

  factory CacheEntry.fromJson(Map<String, dynamic> json, T data) {
    return CacheEntry(
      data: data,
      timestamp: DateTime.parse(json['timestamp'] as String),
      ttl: Duration(milliseconds: json['ttl'] as int),
    );
  }
}

/// Service for managing cached data
class CacheManagerService {
  final SharedPreferences _prefs;
  final Map<String, CacheEntry> _memoryCache = {};

  static const String _cachePrefix = 'cache_';
  static const String _cacheMetaPrefix = 'cache_meta_';

  CacheManagerService(this._prefs);

  /// Get data from cache
  Future<T?> get<T>(String key) async {
    // Check memory cache first
    if (_memoryCache.containsKey(key)) {
      final entry = _memoryCache[key]!;
      if (!entry.isExpired) {
        return entry.data as T;
      } else {
        _memoryCache.remove(key);
        await _removeFromPersistentStorage(key);
      }
    }

    // Check persistent storage
    final cachedData = _prefs.getString('$_cachePrefix$key');
    final cachedMeta = _prefs.getString('$_cacheMetaPrefix$key');

    if (cachedData != null && cachedMeta != null) {
      try {
        final meta = json.decode(cachedMeta) as Map<String, dynamic>;
        final data = json.decode(cachedData);

        final entry = CacheEntry<T>(
          data: data as T,
          timestamp: DateTime.parse(meta['timestamp'] as String),
          ttl: Duration(milliseconds: meta['ttl'] as int),
        );

        if (!entry.isExpired) {
          _memoryCache[key] = entry;
          return entry.data;
        } else {
          await _removeFromPersistentStorage(key);
        }
      } catch (e) {
        await _removeFromPersistentStorage(key);
      }
    }

    return null;
  }

  /// Set data in cache
  Future<void> set<T>(
    String key,
    T data, {
    Duration ttl = const Duration(minutes: 5),
    bool persist = true,
  }) async {
    final entry = CacheEntry<T>(
      data: data,
      timestamp: DateTime.now(),
      ttl: ttl,
    );

    _memoryCache[key] = entry;

    if (persist) {
      try {
        await _prefs.setString('$_cachePrefix$key', json.encode(data));
        await _prefs.setString('$_cacheMetaPrefix$key', json.encode(entry.toJson()));
      } catch (e) {
        // Persist failure shouldn't break the memory cache
      }
    }
  }

  /// Remove data from cache
  Future<void> remove(String key) async {
    _memoryCache.remove(key);
    await _removeFromPersistentStorage(key);
  }

  /// Clear all cached data
  Future<void> clear() async {
    _memoryCache.clear();
    
    final keys = _prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith(_cachePrefix) || key.startsWith(_cacheMetaPrefix)) {
        await _prefs.remove(key);
      }
    }
  }

  /// Check if key exists in cache and is not expired
  Future<bool> has(String key) async {
    final data = await get(key);
    return data != null;
  }

  /// Get or set cache with fallback function
  Future<T> getOrSet<T>(
    String key,
    Future<T> Function() fetchFn, {
    Duration ttl = const Duration(minutes: 5),
    bool persist = true,
  }) async {
    final cached = await get<T>(key);
    if (cached != null) {
      return cached;
    }

    final freshData = await fetchFn();
    await set(key, freshData, ttl: ttl, persist: persist);
    return freshData;
  }

  Future<void> _removeFromPersistentStorage(String key) async {
    await _prefs.remove('$_cachePrefix$key');
    await _prefs.remove('$_cacheMetaPrefix$key');
  }
}
