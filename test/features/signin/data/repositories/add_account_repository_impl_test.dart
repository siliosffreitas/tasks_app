import 'package:tasks_app/core/error/exceptions.dart';
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/features/auth/data/models/account_model.dart';
import 'package:tasks_app/features/signin/data/datasources/add_account_remote_datasource.dart';
import 'package:tasks_app/features/signin/data/repositories/add_account_repository_impl.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockAddAccountRemoteDataSource extends Mock
    implements AddAccountRemoteDataSource {}

void main() {
  late AddAccountRepositoryImp repository;
  late AddAccountRemoteDataSource remoteDataSource;

  late String tUsername;
  late String tPassword;
  late AccountModel account;
  late String errorMessage;

  setUpAll(() {
    registerFallbackValue(AccountModel(accessToken: faker.guid.guid()));
  });

  setUp(() {
    remoteDataSource = MockAddAccountRemoteDataSource();

    repository = AddAccountRepositoryImp(
      remoteDataSource: remoteDataSource,
    );
    tUsername = faker.internet.userName();
    tPassword = faker.internet.password();
    account = AccountModel(accessToken: faker.guid.guid());
    errorMessage = faker.lorem.sentence();

    when(() => remoteDataSource.signin(any(), any()))
        .thenAnswer((_) async => account);
  });

  test(
      'Should return remote data when the call to remote data source is successful',
      () async {
    when(() => remoteDataSource.signin(any(), any()))
        .thenAnswer((_) async => account);

    final response = await repository.signin(tUsername, tPassword);

    verify(() => remoteDataSource.signin(tUsername, tPassword)).called(1);
    expect(response, Right(account));
  });

  test(
      'Should return server failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.signin(any(), any()))
        .thenThrow(ServerException(errorMessage));

    final response = await repository.signin(tUsername, tPassword);

    expect(response, Left(ServerFailure(errorMessage)));
  });

  test(
      'Should return unauthorized failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.signin(any(), any()))
        .thenThrow(UnauthorizedException());

    final response = await repository.signin(tUsername, tPassword);

    expect(response, const Left(UnauthorizedFailure()));
  });
}
