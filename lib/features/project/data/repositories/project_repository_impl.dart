import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/data/source/network/status.dart';
import 'package:smart_task/core/exceptions/exception_handler.dart';
import 'package:smart_task/features/project/data/datasources/local_source.dart';
import 'package:smart_task/features/project/data/datasources/remote_source.dart';
import 'package:smart_task/features/project/data/models/create_project_model.dart';
import 'package:smart_task/features/project/data/models/project.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';
import 'package:smart_task/features/project/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  final NetworkStatus networkStatus;
  final ProjectLocalSource localSource;
  final ProjectRemoteSource remoteSource;

  ProjectRepositoryImpl(
      {required this.localSource,
      required this.remoteSource,
      required this.networkStatus});
  @override
  Future<Either<NetworkFailure, ProjectEntity>> createProject(
      CreateProjectModel request) async {
    try {
      return Right(await remoteSource.createProject(request));
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  @override
  Future<Either<NetworkFailure, List<ProjectEntity>>> getAllProjects() async {
    try {
      List<ProjectModel> projects = [];
      if (await networkStatus.isConnected) {
        projects = await remoteSource.getProjects();
        await localSource.saveProjects(projects);
      } else {
        projects = await localSource.getProjects();
      }

      return Right(projects);
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  @override
  Future<ProjectEntity?> getCurrentProject() {
    return localSource.getCurrentProject();
  }

  @override
  Future<void> setCurrentProject(ProjectEntity project) async {
    await localSource.setCurrentProject(
        ProjectModel(id: project.id, name: project.name, order: project.order));
  }
}
