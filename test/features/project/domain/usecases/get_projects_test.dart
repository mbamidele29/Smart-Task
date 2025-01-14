import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';
import 'package:smart_task/features/project/domain/usecases/get_projects.dart';
import 'package:smart_task/features/project/domain/repositories/project_repository.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  late GetProjects getProjects;
  late ProjectRepository repository;

  final List<ProjectEntity> projects = [
    ProjectEntity(id: '1', name: 'Todo App', order: 1),
  ];
  setUp(() {
    repository = MockProjectRepository();
    getProjects = GetProjects(repository);
  });

  test('should return a list of projects', () async {
    when(() => repository.getAllProjects())
        .thenAnswer((_) async => Right(projects));

    final result = await getProjects();

    expect(result, Right(projects));
    verify(repository.getAllProjects);
    verifyNoMoreInteractions(repository);
  });
}
