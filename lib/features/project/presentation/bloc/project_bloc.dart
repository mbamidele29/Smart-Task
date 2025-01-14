import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';
import 'package:smart_task/features/project/domain/usecases/get_projects.dart';
import 'package:smart_task/features/project/domain/usecases/get_current_project.dart';
import 'package:smart_task/features/project/domain/usecases/set_current_project.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final GetProjects getProjects;
  final GetCurrentProject getCurrentProject;
  final SetCurrentProject setCurrentProject;

  ProjectBloc(
      {required this.getProjects,
      required this.getCurrentProject,
      required this.setCurrentProject})
      : super(ProjectInitial(currentProject: null, projects: [])) {
    on<GetProjectsEvent>(_getProjectsHandler);
    on<AddNewProjectEvent>(_addProjectsHandler);
    on<SetCurrentProjectEvent>(_setCurrentProjectHandler);
    on<GetCurrentProjectEvent>(_getCurrentProjectHandler);
  }

  Future _addProjectsHandler(AddNewProjectEvent event, Emitter emit) async {
    state.projects.add(event.project);
    add(SetCurrentProjectEvent(event.project));
    add(GetProjectsEvent(false, emitState: false));
  }

  Future _getProjectsHandler(GetProjectsEvent event, Emitter emit) async {
    if (!event.reload && state.projects.isNotEmpty) {
      emit(GetProjectsSuccess(
          currentProject: state.currentProject, projects: state.projects));
      return;
    }

    var response = await getProjects();

    response.fold(
      (left) {
        if (event.emitState) {
          emit(GetProjectsError(
              message: left.message,
              projects: state.projects,
              currentProject: state.currentProject));
        }
      },
      (projects) {
        emit(GetProjectsSuccess(
            currentProject: state.currentProject, projects: [...projects]));
      },
    );
  }

  Future _getCurrentProjectHandler(
      GetCurrentProjectEvent event, Emitter emit) async {
    var response = await getCurrentProject();

    response.fold(
      (left) {},
      (project) {
        if (project != null && state.projects.contains(project)) {
          emit(CurrentProjectChanged(
              currentProject: project, projects: state.projects));
        } else {
          if (state.projects.isNotEmpty) {
            add(SetCurrentProjectEvent(state.projects.first));
          }
        }
      },
    );
  }

  Future _setCurrentProjectHandler(
      SetCurrentProjectEvent event, Emitter emit) async {
    var _ = await setCurrentProject(event.project);
    emit(CurrentProjectChanged(
        currentProject: event.project, projects: state.projects));
  }
}
