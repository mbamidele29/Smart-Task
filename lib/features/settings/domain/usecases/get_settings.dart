import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/data/models/no_params.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/features/settings/domain/entities/settings_entity.dart';
import 'package:smart_task/features/settings/domain/repositories/settings_repository.dart';

class GetSettingsUsecase extends BaseUseCase<SettingsEntity?, NoParams> {
  final SettingsRepository repository;

  GetSettingsUsecase(this.repository);

  @override
  Future<Either<NetworkFailure, SettingsEntity?>> call(
      [NoParams? request]) async {
    return await repository.getSettings();
  }
}
