import 'package:tasks_app/core/usecases/usecase.dart';
import 'package:tasks_app/features/home/domain/entities/task_entity.dart';
import 'package:tasks_app/features/home/domain/repositories/load_tasks_repository.dart';
import 'package:tasks_app/features/home/domain/usecases/load_tasks.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';

class MockLoadTasksRepository extends Mock implements LoadTasksRepository {}

void main() {
  late LoadTasks usecase;
  late LoadTasksRepository repository;

  late List<TaskEntity> tasks;

  setUp(() {
    repository = MockLoadTasksRepository();
    usecase = LoadTasksImp(repository: repository);
    tasks = [
      TaskEntity(
        id: faker.guid.guid(),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence(),
      ),
      TaskEntity(
        id: faker.guid.guid(),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence(),
      ),
      TaskEntity(
        id: faker.guid.guid(),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence(),
      ),
    ];
  });

  test('Should call load from the repository', () async {
    when(() => repository.load()).thenAnswer((_) async => Right(tasks));

    final result = await usecase(NoParams());

    expect(result, Right(tasks));
    verify(() => repository.load()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
