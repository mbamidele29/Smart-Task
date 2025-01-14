import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smart_task/features/settings/data/models/settings_model.dart';
import 'package:smart_task/features/settings/domain/usecases/get_settings.dart';
import 'package:smart_task/features/settings/domain/usecases/set_settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<ThemeEvent, SettingsState> {
  final SetSettingsUsecase setSettings;
  final GetSettingsUsecase getSettings;
  SettingsBloc(this.setSettings, this.getSettings)
      : super(ThemeInitial(const Locale("en"), ThemeMode.light)) {
    on<DarkThemeEvent>((_, emit) => _updateTheme(ThemeMode.dark, emit));
    on<LightThemeEvent>((_, emit) => _updateTheme(ThemeMode.light, emit));
    on<ChangeLocalEvent>((event, emit) => _updateLocale(event.locale, emit));
    on<GetSettingsEvent>((_, emit) async {
      var response = await getSettings();

      response.fold((_) {}, (settings) {
        if (settings == null) return;

        emit(UpdateSettingsState(Locale(settings.locale),
            settings.isLightTheme ? ThemeMode.light : ThemeMode.dark));
      });
    });
  }

  void _updateTheme(ThemeMode themeMode, emit) {
    setSettings(
        SettingsModel(state.locale.languageCode, themeMode == ThemeMode.light));
    emit(UpdateSettingsState(state.locale, themeMode));
  }

  void _updateLocale(Locale locale, emit) {
    setSettings(
        SettingsModel(locale.languageCode, state.themeMode == ThemeMode.light));
    emit(UpdateSettingsState(locale, state.themeMode));
  }
}
