import 'package:tasks_app/core/error/exceptions.dart';
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/features/home/data/datasources/load_tasks_remote_datasource.dart';
import 'package:tasks_app/features/home/data/models/task_model.dart';
import 'package:tasks_app/features/home/data/repositories/load_tasks_repository_impl.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockLoadTasksRemoteDataSource extends Mock
    implements LoadTasksRemoteDataSource {}

void main() {
  late LoadTasksRepositoryImpl repository;
  late LoadTasksRemoteDataSource remoteDataSource;

  late String errorMessage;

  late List<TaskModel> tasks;

  setUp(() {
    remoteDataSource = MockLoadTasksRemoteDataSource();

    repository = LoadTasksRepositoryImpl(
      dataSource: remoteDataSource,
    );
    errorMessage = faker.lorem.sentence();

    tasks = [
      TaskModel(
        id: faker.guid.guid(),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence(),
      ),
      TaskModel(
        id: faker.guid.guid(),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence(),
      ),
    ];

    when(() => remoteDataSource.load()).thenAnswer((_) async => tasks);
  });

  test(
      'Should return remote data when the call to remote data source is successful',
      () async {
    final response = await repository.load();

    verify(() => remoteDataSource.load()).called(1);
    expect(response, Right(tasks));
  });

  test(
      'Should return server failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.load())
        .thenThrow(ServerException(errorMessage));

    final response = await repository.load();

    expect(response, Left(ServerFailure(errorMessage)));
  });

  test(
      'Should return unauthorized failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.load()).thenThrow(UnauthorizedException());

    final response = await repository.load();

    expect(response, const Left(UnauthorizedFailure()));
  });
}
