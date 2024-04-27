import 'package:hive/hive.dart';
import 'package:vinhcine/configs/app_config.dart';

class Preferences {
  final Box<dynamic> _box;

  Preferences._(this._box);

  // This doesn't have to be a singleton.
  // We just want to make sure that the box is open, before we start getting/setting objects on it
  static Future<Preferences> getInstance() async {
    final box = await Hive.openBox<dynamic>(AppConfig.ACCESS_TOKEN_KEY);
    return Preferences._(box);
  }

  Future<void> removeValue(String key) {
    return setValue(key, null);
  }

  T getValue<T>(String key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> setValue<T>(String key, T value) => _box.put(key, value);
}
