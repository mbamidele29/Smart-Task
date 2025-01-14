part of 'project_form_bloc.dart';

sealed class ProjectFormState extends Equatable {
  const ProjectFormState();

  @override
  List<Object> get props => [];
}

final class ProjectFormInitial extends ProjectFormState {}

class CreateProjectLoading extends ProjectFormState {}

class CreateProjectSuccess extends ProjectFormState {
  final ProjectEntity project;

  const CreateProjectSuccess(this.project);

  @override
  List<Object> get props => [project];
}

class CreateProjectError extends ProjectFormState {
  final String message;

  const CreateProjectError(this.message);
}
