import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/features/task/data/models/complete_task_model.dart';
import 'package:smart_task/features/task/data/models/create_task_comment_model.dart';
import 'package:smart_task/features/task/data/models/create_task_model.dart';
import 'package:smart_task/features/task/data/models/delete_task_model.dart';
import 'package:smart_task/features/task/data/models/get_active_tasks_model.dart';
import 'package:smart_task/features/task/data/models/get_tasks_comment_model.dart';
import 'package:smart_task/features/task/data/models/get_completed_tasks_model.dart';
import 'package:smart_task/features/task/data/models/reopen_task_model.dart';
import 'package:smart_task/features/task/data/models/update_task_model.dart';
import 'package:smart_task/features/task/data/models/update_task_status_model.dart';
import 'package:smart_task/features/task/domain/entities/comment_entity.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Either<NetworkFailure, void>> reopenTask(ReopenTaskModel params);
  Future<Either<NetworkFailure, void>> deleteTask(DeleteTaskModel params);
  Future<Either<NetworkFailure, void>> completeTask(CompleteTaskModel params);
  Future<Either<NetworkFailure, List<TaskEntity>>> getActiveTasks(
      GetActiveTasksModel params);
  Future<Either<NetworkFailure, List<TaskEntity>>> getCompletedTasks(
      GetCompletedTasksModel params);
  Future<Either<NetworkFailure, TaskEntity>> createTask(
      CreateTaskModel request);
  Future<Either<NetworkFailure, TaskEntity>> updateTask(
      UpdateTaskModel request);
  Future<Either<NetworkFailure, TaskEntity>> updateTaskStatus(
      UpdateTaskStatusModel request);

  Future<Either<NetworkFailure, CommentEntity>> createTaskComment(
      CreateTaskCommentModel request);
  Future<Either<NetworkFailure, List<CommentEntity>>> getTaskComments(
      GetTaskCommentsModel request);
}
