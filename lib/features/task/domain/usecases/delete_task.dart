import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/features/task/data/models/delete_task_model.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class DeleteTaskUseCase implements BaseUseCase<void, DeleteTaskModel> {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  @override
  Future<Either<NetworkFailure, void>> call(DeleteTaskModel params) async {
    return await repository.deleteTask(params);
  }
}
