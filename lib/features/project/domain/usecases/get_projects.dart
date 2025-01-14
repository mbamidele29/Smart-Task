import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/no_params.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';
import 'package:smart_task/features/project/domain/repositories/project_repository.dart';

class GetProjects extends BaseUseCase<List<ProjectEntity>, NoParams> {
  final ProjectRepository repository;
  GetProjects(this.repository);

  @override
  Future<Either<NetworkFailure, List<ProjectEntity>>> call(
      [NoParams? request]) {
    return repository.getAllProjects();
  }
}
