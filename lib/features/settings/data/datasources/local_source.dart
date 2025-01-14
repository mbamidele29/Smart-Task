import 'dart:convert';

import 'package:smart_task/core/data/source/local/storage.dart';
import 'package:smart_task/features/settings/data/models/settings_model.dart';

abstract class SettingsLocalSource {
  SettingsModel? getSettings();
  Future<void> setSettings(SettingsModel request);
}

class SettingsLocalSourceImpl extends SettingsLocalSource {
  final LocalStorage localStorage;
  final String _settingsKey = 'SETTINGS_KEY';

  SettingsLocalSourceImpl(this.localStorage);

  @override
  SettingsModel? getSettings() {
    String? data = localStorage.read(_settingsKey);
    if (data == null) return null;

    return SettingsModel.fromJson(jsonDecode(data));
  }

  @override
  Future<void> setSettings(SettingsModel request) async {
    await localStorage.save(
        key: _settingsKey, value: jsonEncode(request.toJson()));
  }
}
