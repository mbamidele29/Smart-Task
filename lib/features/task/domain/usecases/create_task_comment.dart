import 'package:dartz/dartz.dart';
import 'package:smart_task/core/data/models/error.dart';
import 'package:smart_task/core/models/usecase.dart';
import 'package:smart_task/features/task/data/models/create_task_comment_model.dart';
import 'package:smart_task/features/task/domain/entities/comment_entity.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';

class CreateTaskCommentUseCase
    extends BaseUseCase<CommentEntity, CreateTaskCommentModel> {
  final TaskRepository repository;

  CreateTaskCommentUseCase(this.repository);

  @override
  Future<Either<NetworkFailure, CommentEntity>> call(
      CreateTaskCommentModel request) async {
    return await repository.createTaskComment(request);
  }
}
