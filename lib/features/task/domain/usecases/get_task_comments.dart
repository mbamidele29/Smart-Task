import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/features/task/domain/entities/comment_entity.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';
import 'package:smart_task/features/task/data/models/get_tasks_comment_model.dart';

class GetTaskCommentsUseCase
    extends BaseUseCase<List<CommentEntity>, GetTaskCommentsModel> {
  final TaskRepository repository;

  GetTaskCommentsUseCase(this.repository);

  @override
  Future<Either<NetworkFailure, List<CommentEntity>>> call(
      GetTaskCommentsModel request) async {
    return await repository.getTaskComments(request);
  }
}
