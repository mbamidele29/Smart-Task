part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class CreateTaskLoading extends TaskState {
  final String name;

  const CreateTaskLoading(this.name);
  @override
  List<Object> get props => [name];
}

class CreateTaskSuccess extends TaskState {
  final TaskEntity task;

  const CreateTaskSuccess(this.task);

  @override
  List<Object> get props => [task];
}

class CreateTaskError extends TaskState {
  final String message;

  const CreateTaskError(this.message);
  @override
  List<Object> get props => [message];
}

class UpdateTaskLoading extends TaskState {
  final String name;

  const UpdateTaskLoading(this.name);
  @override
  List<Object> get props => [name];
}

class UpdateTaskSuccess extends TaskState {
  final TaskEntity task;

  const UpdateTaskSuccess(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTaskError extends TaskState {
  final String message;

  const UpdateTaskError(this.message);
  @override
  List<Object> get props => [message];
}

class CreateTaskCommentLoading extends TaskState {
  final String taskId;

  const CreateTaskCommentLoading(this.taskId);
  @override
  List<Object> get props => [taskId];
}

class CreateTaskCommentSuccess extends TaskState {
  final CommentEntity comment;

  const CreateTaskCommentSuccess(this.comment);

  @override
  List<Object> get props => [comment];
}

class CreateTaskCommentError extends TaskState {
  final String taskId;
  final String message;

  const CreateTaskCommentError({required this.taskId, required this.message});

  @override
  List<Object> get props => [taskId, message];
}

class GetTaskCommentsLoading extends TaskState {
  final String taskId;

  const GetTaskCommentsLoading(this.taskId);
  @override
  List<Object> get props => [taskId];
}

class GetTaskCommentsSuccess extends TaskState {
  final String taskId;
  final List<CommentEntity> comments;

  const GetTaskCommentsSuccess({required this.taskId, required this.comments});

  @override
  List<Object> get props => [taskId, comments];
}

class GetTaskCommentsError extends TaskState {
  final String taskId;
  final String message;

  const GetTaskCommentsError({required this.taskId, required this.message});

  @override
  List<Object> get props => [taskId, message];
}
