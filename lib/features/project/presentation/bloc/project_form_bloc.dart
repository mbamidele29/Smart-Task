import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_task/features/project/data/models/create_project_model.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';
import 'package:smart_task/features/project/domain/usecases/create_project.dart';

part 'project_form_event.dart';
part 'project_form_state.dart';

class ProjectFormBloc extends Bloc<ProjectFormEvent, ProjectFormState> {
  final CreateProject createProject;
  ProjectFormBloc(this.createProject) : super(ProjectFormInitial()) {
    on<CreateProjectEvent>(_createProjectHandler);
  }

  Future _createProjectHandler(CreateProjectEvent event, Emitter emit) async {
    emit(CreateProjectLoading());

    var response = await createProject(CreateProjectModel(event.projectName));

    response.fold(
      (left) => emit(CreateProjectError(left.message)),
      (project) => emit(CreateProjectSuccess(project)),
    );
  }
}
