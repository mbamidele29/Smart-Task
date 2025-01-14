import 'package:dartz/dartz.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/data/source/network/status.dart';
import 'package:smart_task/core/exceptions/exception_handler.dart';
import 'package:smart_task/features/task/data/datasources/task_remote_source.dart';
import 'package:smart_task/features/task/data/models/complete_task_model.dart';
import 'package:smart_task/features/task/data/models/create_task_comment_model.dart';
import 'package:smart_task/features/task/data/models/create_task_model.dart';
import 'package:smart_task/features/task/data/models/delete_task_model.dart';
import 'package:smart_task/features/task/data/models/get_active_tasks_model.dart';
import 'package:smart_task/features/task/data/models/get_completed_tasks_model.dart';
import 'package:smart_task/features/task/data/models/get_tasks_comment_model.dart';
import 'package:smart_task/features/task/data/models/reopen_task_model.dart';
import 'package:smart_task/features/task/data/models/update_task_model.dart';
import 'package:smart_task/features/task/data/models/update_task_status_model.dart';
import 'package:smart_task/features/task/domain/entities/comment_entity.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';
import 'package:smart_task/generated/l10n.dart';
import 'package:timezone/timezone.dart' as tz;

class TaskRepositoryImpl extends TaskRepository {
  final NetworkStatus networkStatus;
  final TaskRemoteSource remoteSource;
  final DeviceCalendarPlugin deviceCalendarPlugin;

  TaskRepositoryImpl(
      {required this.remoteSource,
      required this.networkStatus,
      required this.deviceCalendarPlugin});

  @override
  Future<Either<NetworkFailure, void>> completeTask(
      CompleteTaskModel params) async {
    try {
      if (!(await networkStatus.isConnected)) {
        throw NetworkException(S.current.noInternetConnection);
      }
      await remoteSource.completeTask(params);
      deviceCalendarPlugin.deleteEvent(null, params.taskId);
      return Right(null);
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  @override
  Future<Either<NetworkFailure, TaskEntity>> createTask(
      CreateTaskModel request) async {
    try {
      if (!(await networkStatus.isConnected)) {
        throw NetworkException(S.current.noInternetConnection);
      }
      var task = await remoteSource.createTask(request);
      _createOrUpdateTaskCalendar(task);
      return Right(task);
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  @override
  Future<Either<NetworkFailure, void>> deleteTask(
      DeleteTaskModel params) async {
    try {
      if (!(await networkStatus.isConnected)) {
        throw NetworkException(S.current.noInternetConnection);
      }
      await remoteSource.deleteTask(params);
      deviceCalendarPlugin.deleteEvent(null, params.taskId);
      return Right(null);
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  @override
  Future<Either<NetworkFailure, List<TaskEntity>>> getActiveTasks(
      GetActiveTasksModel params) async {
    try {
      if (!(await networkStatus.isConnected)) {
        throw NetworkException(S.current.noInternetConnection);
      }
      return Right(await remoteSource.getActiveTasks(params));
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  @override
  Future<Either<NetworkFailure, List<TaskEntity>>> getCompletedTasks(
      GetCompletedTasksModel params) async {
    try {
      if (!(await networkStatus.isConnected)) {
        throw NetworkException(S.current.noInternetConnection);
      }
      return Right(await remoteSource.getCompleteTasks(params));
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  @override
  Future<Either<NetworkFailure, void>> reopenTask(
      ReopenTaskModel params) async {
    try {
      if (!(await networkStatus.isConnected)) {
        throw NetworkException(S.current.noInternetConnection);
      }
      await remoteSource.reopenTask(params);
      return Right(null);
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  @override
  Future<Either<NetworkFailure, TaskEntity>> updateTask(
      UpdateTaskModel request) async {
    try {
      if (!(await networkStatus.isConnected)) {
        throw NetworkException(S.current.noInternetConnection);
      }

      var task = await remoteSource.updateTask(request);
      _createOrUpdateTaskCalendar(task);
      return Right(task);
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  @override
  Future<Either<NetworkFailure, TaskEntity>> updateTaskStatus(
      UpdateTaskStatusModel request) async {
    try {
      if (!(await networkStatus.isConnected)) {
        throw NetworkException(S.current.noInternetConnection);
      }
      return Right(await remoteSource.updateTaskStatus(request));
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  @override
  Future<Either<NetworkFailure, CommentEntity>> createTaskComment(
      CreateTaskCommentModel request) async {
    try {
      if (!(await networkStatus.isConnected)) {
        throw NetworkException(S.current.noInternetConnection);
      }
      return Right(await remoteSource.createTaskComment(request));
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  @override
  Future<Either<NetworkFailure, List<CommentEntity>>> getTaskComments(
      GetTaskCommentsModel request) async {
    try {
      if (!(await networkStatus.isConnected)) {
        throw NetworkException(S.current.noInternetConnection);
      }
      return Right(await remoteSource.getTaskComments(request));
    } on Exception catch (ex, _) {
      return Left(NetworkFailure(exceptionHandler(ex)));
    }
  }

  void _createOrUpdateTaskCalendar(TaskEntity task) {
    if (task.dueDate?.datetime == null) return;

    final DateTime now = DateTime.now();
    Duration duration = now.isAfter(task.dueDate!.datetime!)
        ? now.difference(task.dueDate!.datetime!)
        : task.dueDate!.datetime!.difference(now);

    deviceCalendarPlugin.createOrUpdateEvent(Event(null,
        eventId: task.id,
        title: task.content,
        end: tz.TZDateTime.now(tz.local).add(duration),
        description: task.description,
        reminders: [Reminder(minutes: 30)]));
  }
}
