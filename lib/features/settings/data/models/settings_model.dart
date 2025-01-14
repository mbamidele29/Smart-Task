import 'package:smart_task/features/settings/domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  SettingsModel(super.locale, super.isLightTheme);

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      SettingsModel(json['locale'], json['isLightTheme']);

  Map<String, dynamic> toJson() =>
      {'locale': locale, 'isLightTheme': isLightTheme};
}
