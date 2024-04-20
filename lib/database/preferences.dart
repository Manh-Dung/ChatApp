import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:vinhcine/models/entities/index.dart';

class Preferences {
  static const _preferencesBox = '_preferencesBox';
  static const _token = '_token';
  final Box<dynamic> _box;

  Preferences._(this._box);

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<Preferences> getInstance() async {
    final box = await Hive.openBox<dynamic>(_preferencesBox);
    return Preferences._(box);
  }

  ///Token

  User? getToken() {
    try {
      String tokenStr = _getValue(_token);
      return User.fromJson(jsonDecode(tokenStr));
    } catch (error) {
      return null;
    }
  }

  Future<void>? setToken(User token) {
    try {
      String tokenStr = jsonEncode(token);
      return _setValue(_token, tokenStr);
    } catch (error) {
      return null;
    }
  }

  Future<void> removeToken() {
    return _setValue(_token, null);
  }

  ///Private method

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);
}
