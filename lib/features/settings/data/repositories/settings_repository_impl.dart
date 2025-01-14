import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/exceptions/exception_handler.dart';
import 'package:smart_task/features/settings/data/datasources/local_source.dart';
import 'package:smart_task/features/settings/data/models/settings_model.dart';
import 'package:smart_task/features/settings/domain/entities/settings_entity.dart';
import 'package:smart_task/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsLocalSource localSource;

  SettingsRepositoryImpl(this.localSource);
  @override
  Future<Either<NetworkFailure, SettingsEntity?>> getSettings() async {
    try {
      return Right(localSource.getSettings());
    } on Exception catch (e, _) {
      return Left(NetworkFailure(exceptionHandler(e)));
    }
  }

  @override
  Future<Either<NetworkFailure, void>> setSettings(
      SettingsModel request) async {
    try {
      await localSource.setSettings(request);
      return Right(null);
    } on Exception catch (e, _) {
      return Left(NetworkFailure(exceptionHandler(e)));
    }
  }
}
