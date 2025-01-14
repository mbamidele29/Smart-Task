import 'package:get_it/get_it.dart';
import 'package:smart_task/features/settings/data/datasources/local_source.dart';
import 'package:smart_task/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:smart_task/features/settings/domain/repositories/settings_repository.dart';
import 'package:smart_task/features/settings/domain/usecases/get_settings.dart';
import 'package:smart_task/features/settings/domain/usecases/set_settings.dart';
import 'package:smart_task/features/settings/presentation/bloc/settings_bloc.dart';

registerSettingsDI(GetIt serviceLocator) {
  final SettingsLocalSource localSource =
      SettingsLocalSourceImpl(serviceLocator());

  final SettingsRepository repository = SettingsRepositoryImpl(localSource);

  final GetSettingsUsecase getSettings = GetSettingsUsecase(repository);
  final SetSettingsUsecase setSettings = SetSettingsUsecase(repository);
  serviceLocator.registerLazySingleton<SettingsBloc>(
      () => SettingsBloc(setSettings, getSettings));
}
