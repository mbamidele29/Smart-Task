part of 'project_bloc.dart';

abstract class ProjectState extends Equatable {
  final ProjectEntity? currentProject;
  final List<ProjectEntity> projects;

  const ProjectState({required this.currentProject, required this.projects});

  @override
  List<Object?> get props => [currentProject, projects];
}

class ProjectInitial extends ProjectState {
  const ProjectInitial(
      {required super.currentProject, required super.projects});
}

class GetProjectsSuccess extends ProjectState {
  const GetProjectsSuccess(
      {required super.currentProject, required super.projects});
}

class CurrentProjectChanged extends ProjectState {
  const CurrentProjectChanged(
      {required super.currentProject, required super.projects});
}

class GetProjectsError extends ProjectState {
  final String message;

  const GetProjectsError(
      {required this.message,
      required super.projects,
      required super.currentProject});

  @override
  List<Object?> get props => [message, projects, currentProject];
}
