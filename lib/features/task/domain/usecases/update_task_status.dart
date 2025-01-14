import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/features/task/data/models/update_task_status_model.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class UpdateTaskStatusUseCase
    implements BaseUseCase<TaskEntity, UpdateTaskStatusModel> {
  final TaskRepository repository;

  UpdateTaskStatusUseCase(this.repository);

  @override
  Future<Either<NetworkFailure, TaskEntity>> call(
      UpdateTaskStatusModel params) async {
    return await repository.updateTaskStatus(params);
  }
}
