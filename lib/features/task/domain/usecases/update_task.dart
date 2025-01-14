import 'package:dartz/dartz.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/features/task/data/models/update_task_model.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class UpdateTaskUseCase implements BaseUseCase<TaskEntity, UpdateTaskModel> {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  @override
  Future<Either<NetworkFailure, TaskEntity>> call(
      UpdateTaskModel params) async {
    return await repository.updateTask(params);
  }
}
