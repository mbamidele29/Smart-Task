import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task/core/values/enums/task_priority.dart';
import 'package:smart_task/features/task/data/models/create_task_model.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';
import 'package:smart_task/features/task/domain/usecases/create_task.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late CreateTaskUseCase createTask;
  late TaskRepository taskRepository;

  final TaskEntity task = TaskEntity(
    id: 'task-12345',
    order: 0,
    dueDate: null,
    commentCount: 0,
    completedAt: null,
    isCompleted: false,
    content: 'Test Task',
    durationInMinute: 5,
    createdAt: DateTime.now(),
    description: 'description',
    priority: TaskPriorityEnum.low,
  );

  final CreateTaskModel request = CreateTaskModel(
      title: task.content,
      dueDate: null,
      priority: null,
      projectId: 'project-1234',
      description: 'description');

  setUp(() {
    taskRepository = MockTaskRepository();
    createTask = CreateTaskUseCase(taskRepository);
  });

  test('should return created task', () async {
    when(() => taskRepository.createTask(request))
        .thenAnswer((_) async => Right(task));

    final comment = await createTask(request);

    expect(comment, Right(task));
    verify(() => taskRepository.createTask(request));
    verifyNoMoreInteractions(taskRepository);
  });
}
