import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task/features/task/data/models/get_active_tasks_model.dart';
import 'package:smart_task/features/task/domain/entities/task.dart';
import 'package:smart_task/features/task/domain/repositories/task_repository.dart';
import 'package:smart_task/features/task/domain/usecases/get_active_tasks.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TaskRepository taskRepository;
  late GetActiveTasksUseCase getActiveTasks;

  final List<TaskEntity> expectedResponse = [];

  setUp(() {
    taskRepository = MockTaskRepository();
    getActiveTasks = GetActiveTasksUseCase(taskRepository);
  });

  test('should return a list of entities', () async {
    var params = GetActiveTasksModel('12345');

    when(() => taskRepository.getActiveTasks(params))
        .thenAnswer((_) async => Right(expectedResponse));

    final tasks = await getActiveTasks(params);

    expect(tasks, Right(expectedResponse));
    verify(() => taskRepository.getActiveTasks(params));
    verifyNoMoreInteractions(taskRepository);
  });
}
