import 'package:tasks_app/features/new_task/domain/repositories/create_task_repository.dart';
import 'package:tasks_app/features/new_task/domain/usecases/create_task.dart';
import 'package:test/test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:dartz/dartz.dart';

class MockCreateTaskRepository extends Mock implements CreateTaskRepository {}

void main() {
  late CreateTask usecase;
  late CreateTaskRepository repository;

  late String tTitle;
  late String tDescription;

  setUp(() {
    repository = MockCreateTaskRepository();
    usecase = CreateTaskImp(repository: repository);
    tTitle = faker.lorem.sentence();
    tDescription = faker.lorem.sentence();
  });

  test('Should get account from the repository', () async {
    when(() => repository.createTask(any(), any()))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(CreateTaskParams(
      title: tTitle,
      description: tDescription,
    ));

    expect(result, const Right(null));
    verify(() => repository.createTask(tTitle, tDescription)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
