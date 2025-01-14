import 'package:dartz/dartz.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/features/task/data/models/get_completed_tasks_model.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class GetCompletedTasksUseCase
    implements BaseUseCase<List<TaskEntity>, GetCompletedTasksModel> {
  final TaskRepository repository;

  GetCompletedTasksUseCase(this.repository);

  @override
  Future<Either<NetworkFailure, List<TaskEntity>>> call(
      GetCompletedTasksModel params) {
    return repository.getCompletedTasks(params);
  }
}
