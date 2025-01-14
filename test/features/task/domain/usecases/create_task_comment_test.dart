import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task/core/values/enums/task_priority.dart';
import 'package:smart_task/features/task/data/models/create_task_comment_model.dart';
import 'package:smart_task/features/task/domain/entities/comment_entity.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';
import 'package:smart_task/features/task/domain/usecases/create_task_comment.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TaskRepository taskRepository;
  late CreateTaskCommentUseCase createTaskComment;

  final TaskEntity task = TaskEntity(
    id: 'task-12345',
    order: 0,
    dueDate: null,
    commentCount: 0,
    completedAt: null,
    isCompleted: false,
    content: 'TestTask',
    durationInMinute: 5,
    createdAt: DateTime.now(),
    description: 'description',
    priority: TaskPriorityEnum.low,
  );

  final CommentEntity commentEntity = CommentEntity(
      id: 'comment-12345',
      taskId: task.id,
      content: 'content',
      postedAt: DateTime.now());

  setUp(() {
    taskRepository = MockTaskRepository();
    createTaskComment = CreateTaskCommentUseCase(taskRepository);
  });

  test('should return a comment', () async {
    var params = CreateTaskCommentModel(taskId: task.id, comment: 'content');

    when(() => taskRepository.createTaskComment(params))
        .thenAnswer((_) async => Right(commentEntity));

    final comment = await createTaskComment(params);

    expect(comment, Right(commentEntity));
    verify(() => taskRepository.createTaskComment(params));
    verifyNoMoreInteractions(taskRepository);
  });
}
