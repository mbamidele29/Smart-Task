import 'package:device_calendar/device_calendar.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_task/features/task/data/datasources/task_remote_source.dart';
import 'package:smart_task/features/task/data/repositories/task_repository_impl.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';
import 'package:smart_task/features/task/domain/usecases/cancel_push_notification_usecase.dart';
import 'package:smart_task/features/task/domain/usecases/complete_task.dart';
import 'package:smart_task/features/task/domain/usecases/create_task.dart';
import 'package:smart_task/features/task/domain/usecases/create_task_comment.dart';
import 'package:smart_task/features/task/domain/usecases/delete_task.dart';
import 'package:smart_task/features/task/domain/usecases/get_active_tasks.dart';
import 'package:smart_task/features/task/domain/usecases/get_completed_tasks.dart';
import 'package:smart_task/features/task/domain/usecases/get_task_comments.dart';
import 'package:smart_task/features/task/domain/usecases/reopen_task.dart';
import 'package:smart_task/features/task/domain/usecases/send_push_notification_usecase.dart';
import 'package:smart_task/features/task/domain/usecases/update_task.dart';
import 'package:smart_task/features/task/domain/usecases/update_task_status.dart';
import 'package:smart_task/features/task/presentation/bloc/task_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/task_tracking_bloc.dart';
import 'package:smart_task/features/task/presentation/bloc/tasks_bloc.dart';

registerTaskDI(GetIt serviceLocator) {
  final TaskRemoteSource remoteSource = TaskRemoteSourceImpl(serviceLocator());
  serviceLocator.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(
      remoteSource: remoteSource, networkStatus: serviceLocator(), deviceCalendarPlugin: DeviceCalendarPlugin()));

  final CompleteTaskUseCase completeTask =
      CompleteTaskUseCase(serviceLocator());
  final CreateTaskUseCase createTask = CreateTaskUseCase(serviceLocator());
  final DeleteTaskUseCase deleteTask = DeleteTaskUseCase(serviceLocator());
  final GetActiveTasksUseCase getActiveTasks =
      GetActiveTasksUseCase(serviceLocator());
  final GetCompletedTasksUseCase getCompletedTasks =
      GetCompletedTasksUseCase(serviceLocator());
  final ReopenTaskUseCase reopenTask = ReopenTaskUseCase(serviceLocator());
  final UpdateTaskUseCase updateTask = UpdateTaskUseCase(serviceLocator());
  final UpdateTaskStatusUseCase updateTaskStatus =
      UpdateTaskStatusUseCase(serviceLocator());
  final GetTaskCommentsUseCase getTaskComments =
      GetTaskCommentsUseCase(serviceLocator());
  final CreateTaskCommentUseCase createTaskComment =
      CreateTaskCommentUseCase(serviceLocator());

  final SendPushNotificationUsecase sendPushNotification =
      SendPushNotificationUsecase(serviceLocator());
  final CancelPushNotificationUsecase cancelPushNotification =
      CancelPushNotificationUsecase(serviceLocator());

  serviceLocator.registerLazySingleton(() => TasksBloc(
      reopenTask,
      deleteTask,
      completeTask,
      getActiveTasks,
      updateTaskStatus,
      getCompletedTasks,
      sendPushNotification));
  serviceLocator.registerLazySingleton(() =>
      TaskBloc(createTask, updateTask, getTaskComments, createTaskComment));
  serviceLocator.registerLazySingleton(
      () => TaskTrackingBloc(sendPushNotification, cancelPushNotification));
}
