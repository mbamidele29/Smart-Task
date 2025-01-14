part of 'project_bloc.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class GetProjectsEvent extends ProjectEvent {
  final bool reload;
  final bool emitState;
  const GetProjectsEvent(this.reload, {this.emitState = true});

  @override
  List<Object> get props => [reload];
}

class GetCurrentProjectEvent extends ProjectEvent {}

class SetCurrentProjectEvent extends ProjectEvent {
  final ProjectEntity project;

  const SetCurrentProjectEvent(this.project);
  @override
  List<Object> get props => [project];
}

class AddNewProjectEvent extends ProjectEvent {
  final ProjectEntity project;

  const AddNewProjectEvent(this.project);
  @override
  List<Object> get props => [project];
}
