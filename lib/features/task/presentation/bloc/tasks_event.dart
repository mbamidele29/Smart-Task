part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class GetActiveTasksEvent extends TasksEvent {
  final String projectId;

  const GetActiveTasksEvent(this.projectId);
}

class AddNewTasksEvent extends TasksEvent {
  final TaskEntity task;

  const AddNewTasksEvent(this.task);
}

class GetCompletedTasksEvent extends TasksEvent {
  final String projectId;

  const GetCompletedTasksEvent(this.projectId);
}

class DeleteTaskEvent extends TasksEvent {
  final TaskEntity task;

  const DeleteTaskEvent(this.task);
}

class CompleteTaskEvent extends TasksEvent {
  final TaskEntity task;

  const CompleteTaskEvent(this.task);
}

class ReopenTaskEvent extends TasksEvent {
  final TaskEntity task;
  final TaskStatusEnum newStatus;

  const ReopenTaskEvent({required this.task, required this.newStatus});
}

class UpdateTaskStatusEvent extends TasksEvent {
  final TaskEntity task;
  final TaskStatusEnum newStatus;

  const UpdateTaskStatusEvent({required this.task, required this.newStatus});
}
