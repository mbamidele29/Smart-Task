import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';
import 'package:smart_task/features/project/domain/repositories/project_repository.dart';

class SetCurrentProject extends BaseUseCase<void, ProjectEntity> {
  final ProjectRepository repository;
  SetCurrentProject(this.repository);

  @override
  Future<Either<NetworkFailure, void>> call(ProjectEntity request) async {
    return Right(await repository.setCurrentProject(request));
  }
}
