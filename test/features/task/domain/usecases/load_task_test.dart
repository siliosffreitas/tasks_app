import 'package:tasks_app/features/home/domain/entities/task_entity.dart';
import 'package:tasks_app/features/task/domain/reposirory/load_task_repository.dart';
import 'package:tasks_app/features/task/domain/usecases/load_task.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';

class MockLoadTaskRepository extends Mock implements LoadTaskRepository {}

void main() {
  late LoadTask usecase;
  late LoadTaskRepository repository;
  late String tTaskId;
  late TaskEntity task;

  setUp(() {
    repository = MockLoadTaskRepository();
    usecase = LoadTaskImp(repository: repository);
    tTaskId = faker.guid.guid();
    task = TaskEntity(
        id: tTaskId,
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence());
  });

  test('Should call load from the repository', () async {
    when(() => repository.load(any())).thenAnswer((_) async => Right(task));

    final result = await usecase(tTaskId);

    expect(result, Right(task));
    verify(() => repository.load(tTaskId)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
