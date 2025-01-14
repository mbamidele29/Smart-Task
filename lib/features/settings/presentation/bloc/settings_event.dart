part of 'settings_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class GetSettingsEvent extends ThemeEvent {}

class DarkThemeEvent extends ThemeEvent {}

class LightThemeEvent extends ThemeEvent {}

class ChangeLocalEvent extends ThemeEvent {
  final Locale locale;

  const ChangeLocalEvent(this.locale);
}
