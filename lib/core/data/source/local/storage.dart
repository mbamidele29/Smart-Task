import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences sharedPreferences;

  LocalStorage({required this.sharedPreferences});

  Future<void> saveBool({required String key, required bool value}) async {
    await sharedPreferences.setBool(key, value);
  }

  bool? readBool(String key) {
    return sharedPreferences.getBool(key);
  }

  Future<void> save({required String key, required String value}) async {
    await sharedPreferences.setString(key, value);
  }

  // Future<void> saveSecure({required String key, required String value}) async {
  //   await secureStorage.write(key: key, value: value);
  // }

  String? read(String key) {
    return sharedPreferences.getString(key);
  }

  // Future<String?> readSecure(String key) async {
  //   return await secureStorage.read(key: key);
  // }
}
