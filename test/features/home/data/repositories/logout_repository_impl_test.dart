import 'package:tasks_app/core/error/exceptions.dart';
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/features/home/data/datasources/logout_remote_datasource.dart';
import 'package:tasks_app/features/home/data/repositories/logout_repository_impl.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockLogoutRemoteDataSource extends Mock
    implements LogoutRemoteDataSource {}

void main() {
  late LogoutRepositoryImpl repository;
  late LogoutRemoteDataSource remoteDataSource;

  late String errorMessage;

  setUp(() {
    remoteDataSource = MockLogoutRemoteDataSource();

    repository = LogoutRepositoryImpl(
      dataSource: remoteDataSource,
    );
    errorMessage = faker.lorem.sentence();

    when(() => remoteDataSource.logout()).thenAnswer((_) async => _);
  });

  test(
      'Should return remote data when the call to remote data source is successful',
      () async {
    await repository.logout();

    verify(() => remoteDataSource.logout()).called(1);
  });

  test(
      'Should return server failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.logout())
        .thenThrow(ServerException(errorMessage));

    final response = await repository.logout();

    expect(response, Left(ServerFailure(errorMessage)));
  });

  test(
      'Should return unauthorized failure when the call to remote data source is unsuccessful',
      () async {
    when(() => remoteDataSource.logout()).thenThrow(UnauthorizedException());

    final response = await repository.logout();

    expect(response, const Left(UnauthorizedFailure()));
  });
}
