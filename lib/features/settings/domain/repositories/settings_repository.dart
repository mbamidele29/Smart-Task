import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/features/settings/data/models/settings_model.dart';
import 'package:smart_task/features/settings/domain/entities/settings_entity.dart';

abstract class SettingsRepository {
  Future<Either<NetworkFailure, SettingsEntity?>> getSettings();
  Future<Either<NetworkFailure, void>> setSettings(SettingsModel request);
}
