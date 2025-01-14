part of 'project_form_bloc.dart';

sealed class ProjectFormEvent extends Equatable {
  const ProjectFormEvent();

  @override
  List<Object> get props => [];
}

class CreateProjectEvent extends ProjectFormEvent {
  final String projectName;

  const CreateProjectEvent(this.projectName);

  @override
  List<Object> get props => [projectName];
}
