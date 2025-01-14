import 'package:dio/dio.dart';
import 'package:smart_task/features/task/data/models/completed_task.dart';
import 'package:smart_task/features/task/data/models/task.dart';
import 'package:smart_task/core/data/source/network/http_service.dart';
import 'package:smart_task/core/exceptions/server_exception.dart';
import 'package:smart_task/features/task/data/models/comment_model.dart';
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

abstract class TaskRemoteSource {
  Future<void> reopenTask(ReopenTaskModel params);
  Future<void> deleteTask(DeleteTaskModel params);
  Future<void> completeTask(CompleteTaskModel params);
  Future<TaskEntity> createTask(CreateTaskModel request);
  Future<TaskEntity> updateTask(UpdateTaskModel request);
  Future<TaskEntity> updateTaskStatus(UpdateTaskStatusModel request);
  Future<List<TaskEntity>> getActiveTasks(GetActiveTasksModel params);
  Future<List<TaskEntity>> getCompleteTasks(GetCompletedTasksModel params);

  Future<CommentEntity> createTaskComment(CreateTaskCommentModel request);
  Future<List<CommentEntity>> getTaskComments(GetTaskCommentsModel request);
}

class TaskRemoteSourceImpl extends TaskRemoteSource {
  final HttpService service;

  final String _taskRoot = 'rest/v2/tasks';
  final String _commentRoot = 'rest/v2/comments';

  TaskRemoteSourceImpl(this.service);

  @override
  Future<void> completeTask(CompleteTaskModel params) async {
    Response response =
        await service.post('$_taskRoot/${params.taskId}/close');
    if (!response.isSuccessful) {
      throw ServerException();
    }
  }

  @override
  Future<void> reopenTask(ReopenTaskModel params) async {
    Response response =
        await service.post('$_taskRoot/${params.taskId}/reopen');
    if (!response.isSuccessful) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteTask(DeleteTaskModel params) async {
    Response response = await service.delete('$_taskRoot/${params.taskId}');
    if (!response.isSuccessful) {
      throw ServerException();
    }
  }

  @override
  Future<List<TaskEntity>> getActiveTasks(GetActiveTasksModel params) async {
    Response response =
        await service.getRequest(_taskRoot, queryParameters: params.toJson());
    if (response.isSuccessful) {
      return (response.data as List).map((e) => TaskModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TaskEntity>> getCompleteTasks(
      GetCompletedTasksModel params) async {
    Response response = await service.getRequest('sync/v9/completed/get_all',
        queryParameters: params.toJson());
    if (response.isSuccessful) {
      return (response.data['items'] as List)
          .map((e) => CompletedTasksModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TaskEntity> createTask(CreateTaskModel request) async {
    Response response = await service.post(_taskRoot, data: request.toJson());
    if (response.isSuccessful) {
      return TaskModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TaskEntity> updateTask(UpdateTaskModel request) async {
    Response response =
        await service.post('$_taskRoot/${request.id}', data: request.toJson());
    if (response.isSuccessful) {
      return TaskModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TaskEntity> updateTaskStatus(UpdateTaskStatusModel request) async {
    Response response =
        await service.post('$_taskRoot/${request.id}', data: request.toJson());
    if (response.isSuccessful) {
      return TaskModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CommentEntity> createTaskComment(
      CreateTaskCommentModel request) async {
    Response response =
        await service.post(_commentRoot, data: request.toJson());
    if (response.isSuccessful) {
      return CommentModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CommentEntity>> getTaskComments(
      GetTaskCommentsModel request) async {
    Response response = await service.getRequest(_commentRoot,
        queryParameters: request.toJson());
    if (response.isSuccessful) {
      return (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
