import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/no_params.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';
import 'package:smart_task/features/project/domain/repositories/project_repository.dart';

class GetCurrentProject extends BaseUseCase<ProjectEntity?, NoParams> {
  final ProjectRepository repository;
  GetCurrentProject(this.repository);

  @override
  Future<Either<NetworkFailure, ProjectEntity?>> call(
      [NoParams? request]) async {
    return Right(await repository.getCurrentProject());
  }
}
