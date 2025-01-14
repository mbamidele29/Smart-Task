import 'package:dartz/dartz.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/features/project/data/models/create_project_model.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';
import 'package:smart_task/features/project/domain/repositories/project_repository.dart';

class CreateProject extends BaseUseCase<ProjectEntity, CreateProjectModel> {
  final ProjectRepository repository;
  CreateProject(this.repository);

  @override
  Future<Either<NetworkFailure, ProjectEntity>> call(
      CreateProjectModel request) async {
    return await repository.createProject(request);
  }
}
