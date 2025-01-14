import 'package:dartz/dartz.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/features/task/data/models/get_active_tasks_model.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class GetActiveTasksUseCase
    implements BaseUseCase<List<TaskEntity>, GetActiveTasksModel> {
  final TaskRepository repository;

  GetActiveTasksUseCase(this.repository);

  @override
  Future<Either<NetworkFailure, List<TaskEntity>>> call(
      GetActiveTasksModel params) {
    return repository.getActiveTasks(params);
  }
}
