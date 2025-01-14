part of 'tasks_bloc.dart';

abstract class TasksState /* extends Equatable */ {
  final String projectId;
  final Map<TaskStatusEnum, Set<TaskEntity>?> tasks;

  TasksState({required this.projectId, required this.tasks});

  // @override
  // List<Object?> get props => [tasks];
}

class TasksInitial extends TasksState {
  TasksInitial({required super.projectId, required super.tasks});
}

class TasksLoading extends TasksState {
  TasksLoading({required super.projectId, required super.tasks});
}

class TasksSuccess extends TasksState {
  TasksSuccess({required super.projectId, required super.tasks});
}

class TasksError extends TasksState {
  final String message;

  TasksError(
      {required super.projectId, required super.tasks, required this.message});
}
