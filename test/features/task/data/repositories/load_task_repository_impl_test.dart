import 'package:tasks_app/core/error/exceptions.dart';
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/features/home/data/models/task_model.dart';
import 'package:tasks_app/features/task/data/datasources/load_task_remote_datasource.dart';
import 'package:tasks_app/features/task/data/repositories/load_task_repository_impl.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockLoadTaskRemoteDataSource extends Mock
    implements LoadTaskRemoteDataSource {}

void main() {
  late LoadTaskRepositoryImpl repository;
  late LoadTaskRemoteDataSource remoteDataSource;

  late String errorMessage;
  late String tTaskId;
  late TaskModel tTask;

  setUp(() {
    remoteDataSource = MockLoadTaskRemoteDataSource();

    repository = LoadTaskRepositoryImpl(
      dataSource: remoteDataSource,
    );
    tTaskId = faker.guid.guid();
    tTask = TaskModel(
      id: tTaskId,
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
    );

    errorMessage = faker.lorem.sentence();

    when(() => remoteDataSource.load(any())).thenAnswer((_) async => tTask);
  });

  test(
      'Should return remote data when the call to remote data source is successful',
      () async {
    await repository.load(tTaskId);

    verify(() => remoteDataSource.load(tTaskId)).called(1);
  });

  test(
      'Should return server failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.load(any()))
        .thenThrow(ServerException(errorMessage));

    final response = await repository.load(tTaskId);

    expect(response, Left(ServerFailure(errorMessage)));
  });

  test(
      'Should return unauthorized failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.load(any())).thenThrow(UnauthorizedException());

    final response = await repository.load(tTaskId);

    expect(response, const Left(UnauthorizedFailure()));
  });
}
