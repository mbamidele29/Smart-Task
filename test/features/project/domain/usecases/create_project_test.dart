import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task/features/project/domain/entities/project.dart';
import 'package:smart_task/features/project/domain/usecases/create_project.dart';
import 'package:smart_task/features/project/data/models/create_project_model.dart';
import 'package:smart_task/features/project/domain/repositories/project_repository.dart';

class MockProjectRepository extends Mock implements ProjectRepository {}

void main() {
  late CreateProject createProject;
  late ProjectRepository repository;

  final CreateProjectModel request = CreateProjectModel("name");
  final ProjectEntity project =
      ProjectEntity(id: '1', name: 'Todo App', order: 1);

  setUp(() {
    repository = MockProjectRepository();
    createProject = CreateProject(repository);
  });

  test("should create and return a single project", () async {
    when(() => repository.createProject(request))
        .thenAnswer((_) async => Right(project));

    final result = await createProject(request);

    expect(result, Right(project));
    verify(() => repository.createProject(request)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
