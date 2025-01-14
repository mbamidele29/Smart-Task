part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  final Locale locale;
  final ThemeMode themeMode;

  const SettingsState(this.locale, this.themeMode);

  @override
  List<Object> get props => [locale, themeMode];
}

final class ThemeInitial extends SettingsState {
  const ThemeInitial(super.locale, super.themeMode);
}

final class UpdateSettingsState extends SettingsState {
  const UpdateSettingsState(super.locale, super.themeMode);
}
