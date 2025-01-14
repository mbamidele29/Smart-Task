import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/features/project/data/models/create_project_model.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';

abstract class ProjectRepository {
  Future<ProjectEntity?> getCurrentProject();
  Future<void> setCurrentProject(ProjectEntity project);
  Future<Either<NetworkFailure, List<ProjectEntity>>> getAllProjects();
  Future<Either<NetworkFailure, ProjectEntity>> createProject(
      CreateProjectModel request);
}
