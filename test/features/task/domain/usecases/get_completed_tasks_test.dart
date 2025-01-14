import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task/features/task/data/models/get_completed_tasks_model.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';
import 'package:smart_task/features/task/domain/usecases/get_completed_tasks.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TaskRepository taskRepository;
  late GetCompletedTasksUseCase getCompletedTasks;

  final List<TaskEntity> expectedResponse = [];

  setUp(() {
    taskRepository = MockTaskRepository();
    getCompletedTasks = GetCompletedTasksUseCase(taskRepository);
  });

  test('should return a list of completed tasks', () async {
    var params = GetCompletedTasksModel('12345');

    when(() => taskRepository.getCompletedTasks(params))
        .thenAnswer((_) async => Right(expectedResponse));

    final tasks = await getCompletedTasks(params);

    expect(tasks, Right(expectedResponse));
    verify(() => taskRepository.getCompletedTasks(params));
    verifyNoMoreInteractions(taskRepository);
  });
}
