import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_task/features/task/data/models/create_task_comment_model.dart';
import 'package:smart_task/features/task/data/models/create_task_model.dart';
import 'package:smart_task/features/task/data/models/get_tasks_comment_model.dart';
import 'package:smart_task/features/task/data/models/update_task_model.dart';
import 'package:smart_task/features/task/domain/entities/comment_entity.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/usecases/create_task.dart';
import 'package:smart_task/features/task/domain/usecases/create_task_comment.dart';
import 'package:smart_task/features/task/domain/usecases/get_task_comments.dart';
import 'package:smart_task/features/task/domain/usecases/update_task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final CreateTaskUseCase createTask;
  final UpdateTaskUseCase updateTask;
  final GetTaskCommentsUseCase getTaskComments;
  final CreateTaskCommentUseCase createTaskComment;

  TaskBloc(
    this.createTask,
    this.updateTask,
    this.getTaskComments,
    this.createTaskComment,
  ) : super(TaskInitial()) {
    on<CreateTaskEvent>(_createTaskHandler);
    on<UpdateTaskEvent>(_updateTaskHandler);
    on<GetTaskCommentsEvent>(_getTaskCommentsHandler);
    on<CreateTaskCommentEvent>(_createTaskCommentHandler);
  }

  Future _createTaskHandler(CreateTaskEvent event, emit) async {
    emit(CreateTaskLoading(event.title));
    var response = await createTask(CreateTaskModel(
        title: event.title,
        dueDate: event.dueDate,
        priority: event.priority,
        projectId: event.projectId,
        description: event.description));

    response.fold((left) => emit(CreateTaskError(left.message)),
        (task) => emit(CreateTaskSuccess(task)));
  }

  Future _updateTaskHandler(UpdateTaskEvent event, emit) async {
    emit(UpdateTaskLoading(event.id));
    var response = await updateTask(UpdateTaskModel(
        id: event.id,
        title: event.title,
        labels: event.labels,
        dueDate: event.dueDate,
        priority: event.priority,
        duration: event.duration,
        description: event.description));

    response.fold((left) => emit(UpdateTaskError(left.message)),
        (task) => emit(UpdateTaskSuccess(task)));
  }

  Future _getTaskCommentsHandler(GetTaskCommentsEvent event, emit) async {
    emit(GetTaskCommentsLoading(event.taskId));
    var response = await getTaskComments(GetTaskCommentsModel(event.taskId));

    response.fold(
        (left) => emit(
            GetTaskCommentsError(taskId: event.taskId, message: left.message)),
        (comments) => emit(
            GetTaskCommentsSuccess(taskId: event.taskId, comments: comments)));
  }

  Future _createTaskCommentHandler(CreateTaskCommentEvent event, emit) async {
    emit(CreateTaskCommentLoading(event.taskId));
    var response = await createTaskComment(
        CreateTaskCommentModel(taskId: event.taskId, comment: event.comment));

    response.fold(
        (left) => emit(CreateTaskCommentError(
            taskId: event.taskId, message: left.message)),
        (comment) => emit(CreateTaskCommentSuccess(comment)));
  }
}
