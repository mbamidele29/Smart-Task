import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/features/settings/data/models/settings_model.dart';
import 'package:smart_task/features/settings/domain/repositories/settings_repository.dart';

class SetSettingsUsecase extends BaseUseCase<void, SettingsModel> {
  final SettingsRepository repository;

  SetSettingsUsecase(this.repository);

  @override
  Future<Either<NetworkFailure, void>> call(SettingsModel request) {
    return repository.setSettings(request);
  }
}
