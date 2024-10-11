import 'package:tasks_app/core/error/exceptions.dart';
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/features/auth/data/models/account_model.dart';
import 'package:tasks_app/features/new_task/data/datasources/create_task_remote_datasource.dart';
import 'package:tasks_app/features/new_task/data/repositories/create_task_repository_impl.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockCreateTaskRemoteDataSource extends Mock
    implements CreateTaskRemoteDataSource {}

void main() {
  late CreateTaskRepositoryImpl repository;
  late CreateTaskRemoteDataSource remoteDataSource;

  late String tTitle;
  late String tDescription;
  late AccountModel account;
  late String errorMessage;

  setUp(() {
    remoteDataSource = MockCreateTaskRemoteDataSource();

    repository = CreateTaskRepositoryImpl(
      dataSource: remoteDataSource,
    );
    tTitle = faker.internet.userName();
    tDescription = faker.internet.password();
    account = AccountModel(accessToken: faker.guid.guid());
    errorMessage = faker.lorem.sentence();

    when(() => remoteDataSource.createTask(any(), any()))
        .thenAnswer((_) async => account);
  });

  test(
      'Should return remote data when the call to remote data source is successful',
      () async {
    when(() => remoteDataSource.createTask(any(), any()))
        .thenAnswer((_) async => account);

    final response = await repository.createTask(tTitle, tDescription);

    verify(() => remoteDataSource.createTask(tTitle, tDescription)).called(1);
    expect(response, Right(account));
  });

  test(
      'Should return server failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.createTask(any(), any()))
        .thenThrow(ServerException(errorMessage));

    final response = await repository.createTask(tTitle, tDescription);

    expect(response, Left(ServerFailure(errorMessage)));
  });

  test(
      'Should return unauthorized failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.createTask(any(), any()))
        .thenThrow(UnauthorizedException());

    final response = await repository.createTask(tTitle, tDescription);

    expect(response, const Left(UnauthorizedFailure()));
  });
}
