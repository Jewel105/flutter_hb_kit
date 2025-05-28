import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HbStorage {
  static late SharedPreferencesWithCache _preferences;

  /// Initialize the shared preferences with a cache
  static Future<void> init() async {
    _preferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }

  /// Save data to the local cache
  /// 设置本地缓存
  static Future<void> set<T>(String key, T value) {
    if (value is String) {
      return _preferences.setString(key, value as String);
    } else if (value is int) {
      return _preferences.setInt(key, value as int);
    } else if (value is bool) {
      return _preferences.setBool(key, value as bool);
    } else if (value is double) {
      return _preferences.setDouble(key, value as double);
    } else if (value is List<String>) {
      return _preferences.setStringList(key, value as List<String>);
    } else if (value is Map<String, dynamic> || value is Map || value is List) {
      return _preferences.setString(key, json.encode(value));
    } else {
      return Future<void>.value();
    }
  }

  /// Retrieve data from the local cache
  /// 取出缓存
  static T? get<T>(String key) {
    Object? value = _preferences.get(key);
    if (value is String) {
      try {
        return json.decode(value);
      } catch (_) {
        return value as T?;
      }
    }
    return value as T?;
  }

  /// Clear data from the local cache
  /// 删除缓存
  static Future<void> remove(String key) {
    return _preferences.remove(key);
  }
}
