import 'package:dartz/dartz.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/features/task/data/models/create_task_model.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class CreateTaskUseCase implements BaseUseCase<TaskEntity, CreateTaskModel> {
  final TaskRepository repository;

  CreateTaskUseCase(this.repository);

  @override
  Future<Either<NetworkFailure, TaskEntity>> call(
      CreateTaskModel params) async {
    return await repository.createTask(params);
  }
}
