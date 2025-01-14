part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class CreateTaskEvent extends TaskEvent {
  final String title;
  final int? priority;
  final String projectId;
  final DateTime? dueDate;
  final String? description;

  const CreateTaskEvent(
      {required this.title,
      required this.dueDate,
      required this.priority,
      required this.projectId,
      required this.description});

  @override
  List<Object?> get props => [title, dueDate, priority, projectId, description];
}

class UpdateTaskEvent extends TaskEvent {
  final String id;
  final int? duration;
  final int? priority;
  final String? title;
  final DateTime? dueDate;
  final String? description;
  final List<String>? labels;

  const UpdateTaskEvent({
    this.title,
    this.labels,
    this.dueDate,
    this.priority,
    this.duration,
    this.description,
    required this.id,
  });

  @override
  List<Object?> get props =>
      [id, title, labels, dueDate, priority, description];
}

class CreateTaskCommentEvent extends TaskEvent {
  final String taskId;
  final String comment;

  const CreateTaskCommentEvent({required this.taskId, required this.comment});

  @override
  List<Object?> get props => [taskId, comment];
}

class GetTaskCommentsEvent extends TaskEvent {
  final String taskId;

  const GetTaskCommentsEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}
