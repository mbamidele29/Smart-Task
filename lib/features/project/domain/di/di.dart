import 'package:get_it/get_it.dart';
import 'package:smart_task/features/project/data/datasources/local_source.dart';
import 'package:smart_task/features/project/data/datasources/remote_source.dart';
import 'package:smart_task/features/project/data/repositories/project_repository_impl.dart';
import 'package:smart_task/features/project/domain/repositories/project_repository.dart';
import 'package:smart_task/features/project/domain/usecases/create_project.dart';
import 'package:smart_task/features/project/domain/usecases/get_current_project.dart';
import 'package:smart_task/features/project/domain/usecases/get_projects.dart';
import 'package:smart_task/features/project/domain/usecases/set_current_project.dart';
import 'package:smart_task/features/project/presentation/bloc/project_bloc.dart';
import 'package:smart_task/features/project/presentation/bloc/project_form_bloc.dart';

registerProjectDI(GetIt serviceLocator) {
  final ProjectRemoteSource remoteSource =
      ProjectRemoteSourceImpl(serviceLocator());
  final ProjectLocalSource localSource =
      ProjectLocalSourceImpl(serviceLocator());

  serviceLocator.registerLazySingleton<ProjectRepository>(() =>
      ProjectRepositoryImpl(
          localSource: localSource,
          remoteSource: remoteSource,
          networkStatus: serviceLocator()));

  final GetProjects getProjects = GetProjects(serviceLocator());
  final CreateProject createProject = CreateProject(serviceLocator());

  final GetCurrentProject getCurrentProject =
      GetCurrentProject(serviceLocator());
  final SetCurrentProject setCurrentProject =
      SetCurrentProject(serviceLocator());

  serviceLocator.registerLazySingleton(() => ProjectBloc(
      getProjects: getProjects,
      getCurrentProject: getCurrentProject,
      setCurrentProject: setCurrentProject));
  serviceLocator.registerLazySingleton(() => ProjectFormBloc(createProject));
}
