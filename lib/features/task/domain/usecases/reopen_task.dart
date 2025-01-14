import 'package:dartz/dartz.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/features/task/data/models/reopen_task_model.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class ReopenTaskUseCase implements BaseUseCase<void, ReopenTaskModel> {
  final TaskRepository repository;

  ReopenTaskUseCase(this.repository);

  @override
  Future<Either<NetworkFailure, void>> call(ReopenTaskModel params) async {
    return await repository.reopenTask(params);
  }
}
