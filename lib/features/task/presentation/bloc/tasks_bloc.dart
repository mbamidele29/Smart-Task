import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_task/core/di/di.dart';
import 'package:smart_task/core/models/push_notification_payload.dart';
import 'package:smart_task/core/values/enums/task_status.dart';
import 'package:smart_task/features/task/data/models/complete_task_model.dart';
import 'package:smart_task/features/task/data/models/delete_task_model.dart';
import 'package:smart_task/features/task/data/models/get_active_tasks_model.dart';
import 'package:smart_task/features/task/data/models/get_completed_tasks_model.dart';
import 'package:smart_task/features/task/data/models/reopen_task_model.dart';
import 'package:smart_task/features/task/data/models/update_task_status_model.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/usecases/complete_task.dart';
import 'package:smart_task/features/task/domain/usecases/delete_task.dart';
import 'package:smart_task/features/task/domain/usecases/get_active_tasks.dart';
import 'package:smart_task/features/task/domain/usecases/get_completed_tasks.dart';
import 'package:smart_task/features/task/domain/usecases/reopen_task.dart';
import 'package:smart_task/features/task/domain/usecases/send_push_notification_usecase.dart';
import 'package:smart_task/features/task/domain/usecases/update_task_status.dart';
import 'package:smart_task/features/task/presentation/bloc/task_tracking_bloc.dart';
import 'package:smart_task/generated/l10n.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final ReopenTaskUseCase reopenTask;
  final DeleteTaskUseCase deleteTask;
  final CompleteTaskUseCase completeTask;
  final GetActiveTasksUseCase getActiveTasks;
  final UpdateTaskStatusUseCase updateTaskStatus;
  final GetCompletedTasksUseCase getCompletedTasks;
  final SendPushNotificationUsecase sendPushNotification;
  TasksBloc(
    this.reopenTask,
    this.deleteTask,
    this.completeTask,
    this.getActiveTasks,
    this.updateTaskStatus,
    this.getCompletedTasks,
    this.sendPushNotification,
  ) : super(TasksInitial(projectId: '', tasks: {})) {
    on<ReopenTaskEvent>(_reopenTaskHandler);
    on<DeleteTaskEvent>(_deleteTaskHandler);
    on<AddNewTasksEvent>(_addNewTaskHandler);
    on<CompleteTaskEvent>(_completeTaskHandler);
    on<GetActiveTasksEvent>(_activeTasksHandler);
    on<GetCompletedTasksEvent>(_completedTasksHandler);
    on<UpdateTaskStatusEvent>(_updateTaskStatusHandler);
  }

  Future _deleteTaskHandler(DeleteTaskEvent event, Emitter emit) async {
    var tasks_ = _shuffleTasks(
        task: event.task, oldStatus: event.task.status, newStatus: null);

    emit(TasksSuccess(projectId: state.projectId, tasks: tasks_));

    var response = await deleteTask(DeleteTaskModel(event.task.id));

    response.fold((left) {}, (_) {});
  }

  Future _reopenTaskHandler(ReopenTaskEvent event, Emitter emit) async {
    TaskStatusEnum oldStatus = event.task.status;

    var tasks_ = _shuffleTasks(
        task: event.task, oldStatus: oldStatus, newStatus: event.newStatus);
    emit(TasksSuccess(projectId: state.projectId, tasks: tasks_));

    var response = await reopenTask(ReopenTaskModel(event.task.id));

    response.fold((left) {}, (task) {
      var tasks_ = _shuffleTasks(
          task: event.task, oldStatus: oldStatus, newStatus: event.newStatus);

      emit(TasksSuccess(projectId: state.projectId, tasks: tasks_));
    });
  }

  Future _completeTaskHandler(CompleteTaskEvent event, Emitter emit) async {
    TaskStatusEnum oldStatus = event.task.status;

    var tasks_ = _shuffleTasks(
        task: event.task, oldStatus: oldStatus, newStatus: TaskStatusEnum.done);
    sendPushNotification(PushNotificationPayload(
        id: event.task.hashCode,
        title: S.current.hurray,
        body: S.current.youCompletedATask));

    emit(TasksSuccess(projectId: state.projectId, tasks: tasks_));

    var response = await completeTask(CompleteTaskModel(event.task.id));

    response.fold((left) {}, (task) {
      var tasks_ = _shuffleTasks(
          task: event.task,
          oldStatus: oldStatus,
          newStatus: TaskStatusEnum.done);
      emit(TasksSuccess(projectId: state.projectId, tasks: tasks_));
    });
  }

  Future _updateTaskStatusHandler(
      UpdateTaskStatusEvent event, Emitter emit) async {
    TaskStatusEnum oldStatus = event.task.status;
    if (oldStatus == event.newStatus) return;

    if (event.task.status == TaskStatusEnum.done) {
      add(ReopenTaskEvent(task: event.task, newStatus: event.newStatus));
      return;
    }

    if (event.newStatus == TaskStatusEnum.done) {
      serviceLocator<TaskTrackingBloc>().add(StopTrackingEvent(event.task));
      add(CompleteTaskEvent(event.task));
      return;
    }
    int? durationInMinute = oldStatus == TaskStatusEnum.todo ||
            event.newStatus == TaskStatusEnum.inProgress
        ? (event.task.durationInMinute ?? 1)
        : null;

    var tasks_ = _shuffleTasks(
        task: event.task, oldStatus: oldStatus, newStatus: event.newStatus);

    emit(TasksSuccess(projectId: state.projectId, tasks: tasks_));

    var response = await updateTaskStatus(UpdateTaskStatusModel(
        id: event.task.id, durationInMinute: durationInMinute));

    response.fold((left) {}, (task) {
      var tasks_ = _shuffleTasks(
          task: task, oldStatus: oldStatus, newStatus: event.newStatus);

      emit(TasksSuccess(projectId: state.projectId, tasks: tasks_));
    });
  }

  Future _addNewTaskHandler(AddNewTasksEvent event, Emitter emit) async {
    var tasks_ = _shuffleTasks(
        task: event.task, oldStatus: null, newStatus: TaskStatusEnum.todo);

    emit(TasksSuccess(projectId: state.projectId, tasks: tasks_));
  }

  Future _activeTasksHandler(GetActiveTasksEvent event, Emitter emit) async {
    var tasks_ = state.tasks;

    if (event.projectId != state.projectId) {
      tasks_.remove(TaskStatusEnum.todo);
      tasks_.remove(TaskStatusEnum.inProgress);
      emit(TasksLoading(projectId: event.projectId, tasks: tasks_));
    }
    var response = await getActiveTasks(GetActiveTasksModel(event.projectId));

    response.fold(
      (left) => emit(TasksError(
          projectId: event.projectId,
          message: left.message,
          tasks: state.tasks)),
      (tasks) {
        Set<TaskEntity> todoTasks = {};
        Set<TaskEntity> inProgressTasks = {};

        for (TaskEntity task in tasks.reversed) {
          if (task.durationInMinute == null) {
            todoTasks.add(task);
          } else {
            inProgressTasks.add(task);
          }
        }

        var tasks_ = state.tasks;
        tasks_[TaskStatusEnum.todo] = todoTasks;
        tasks_[TaskStatusEnum.inProgress] = inProgressTasks;

        emit(TasksSuccess(projectId: event.projectId, tasks: tasks_));
      },
    );
  }

  Future _completedTasksHandler(
      GetCompletedTasksEvent event, Emitter emit) async {
    var tasks_ = state.tasks;

    if (event.projectId != state.projectId) {
      tasks_.remove(TaskStatusEnum.done);
      emit(TasksLoading(projectId: event.projectId, tasks: tasks_));
    }
    var response =
        await getCompletedTasks(GetCompletedTasksModel(event.projectId));

    response.fold(
      (left) => emit(TasksError(
          projectId: state.projectId,
          message: left.message,
          tasks: state.tasks)),
      (tasks) {
        var tasks_ = state.tasks;
        tasks_[TaskStatusEnum.done] = tasks.toSet();

        emit(TasksSuccess(projectId: event.projectId, tasks: tasks_));
      },
    );
  }

  Map<TaskStatusEnum, Set<TaskEntity>?> _shuffleTasks({
    required TaskEntity task,
    required TaskStatusEnum? oldStatus,
    required TaskStatusEnum? newStatus,
  }) {
    var tasks_ = state.tasks;

    if (oldStatus != null) tasks_[oldStatus] = tasks_[oldStatus]!..remove(task);
    if (newStatus != null) {
      tasks_[newStatus] = {task, ...(tasks_[newStatus] ?? [])};
    }

    return tasks_;
  }
}
