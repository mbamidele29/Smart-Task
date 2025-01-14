import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/features/task/data/models/complete_task_model.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class CompleteTaskUseCase implements BaseUseCase<void, CompleteTaskModel> {
  final TaskRepository repository;

  CompleteTaskUseCase(this.repository);

  @override
  Future<Either<NetworkFailure, void>> call(CompleteTaskModel params) async {
    return await repository.completeTask(params);
  }
}
