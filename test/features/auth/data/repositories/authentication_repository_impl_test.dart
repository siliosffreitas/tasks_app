import 'package:tasks_app/core/error/exceptions.dart';
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/features/auth/data/datasources/authentication_remote_datasource.dart';
import 'package:tasks_app/features/auth/data/models/account_model.dart';
import 'package:tasks_app/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRepositoryImp repository;
  late AuthenticationRemoteDataSource remoteDataSource;

  late String tUsername;
  late String tPassword;
  late AccountModel account;
  late String errorMessage;

  setUpAll(() {
    registerFallbackValue(AccountModel(accessToken: faker.guid.guid()));
  });

  setUp(() {
    remoteDataSource = MockAuthenticationRemoteDataSource();

    repository = AuthenticationRepositoryImp(
      remoteDataSource: remoteDataSource,
    );
    tUsername = faker.internet.userName();
    tPassword = faker.internet.password();
    account = AccountModel(accessToken: faker.guid.guid());
    errorMessage = faker.lorem.sentence();

    when(() => remoteDataSource.login(any(), any()))
        .thenAnswer((_) async => account);
  });

  test(
      'Should return remote data when the call to remote data source is successful',
      () async {
    when(() => remoteDataSource.login(any(), any()))
        .thenAnswer((_) async => account);

    final response = await repository.login(tUsername, tPassword);

    verify(() => remoteDataSource.login(tUsername, tPassword)).called(1);
    expect(response, Right(account));
  });

  test(
      'Should return server failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.login(any(), any()))
        .thenThrow(ServerException(errorMessage));

    final response = await repository.login(tUsername, tPassword);

    expect(response, Left(ServerFailure(errorMessage)));
  });

  test(
      'Should return unauthorized failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.login(any(), any()))
        .thenThrow(UnauthorizedException());

    final response = await repository.login(tUsername, tPassword);

    expect(response, const Left(UnauthorizedFailure()));
  });
}
