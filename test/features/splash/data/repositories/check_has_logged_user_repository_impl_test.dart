import 'package:tasks_app/core/error/exceptions.dart';
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/features/auth/data/models/account_model.dart';
import 'package:tasks_app/features/splash/data/datasources/check_has_logged_user_remote_datasource.dart';
import 'package:tasks_app/features/splash/data/repositories/check_has_logged_user_repository_impl.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';

class MockCheckHasLoggedUserRemoteDataSource extends Mock
    implements CheckHasLoggedUserRemoteDataSource {}

void main() {
  late CheckHasLoggedUserRepositoryImp repository;
  late CheckHasLoggedUserRemoteDataSource datasource;
  late AccountModel tAccountModel;
  late String tErrorMessage;

  setUp(() {
    datasource = MockCheckHasLoggedUserRemoteDataSource();
    repository = CheckHasLoggedUserRepositoryImp(
      remoteDataSource: datasource,
    );
    tAccountModel = AccountModel(accessToken: faker.guid.guid());

    when(() => datasource.check()).thenAnswer((_) async => tAccountModel);
    tErrorMessage = faker.lorem.sentence();
  });

  test('Should return local data when source is successful', () async {
    final response = await repository.check();

    verify(() => datasource.check()).called(1);
    expect(response, Right(tAccountModel));
  });

  test(
      'Should return cache failure when the call to local data source is unsuccessful',
      () async {
    when(() => datasource.check()).thenThrow(UnauthorizedException());

    final response = await repository.check();

    expect(response, const Left(UnauthorizedFailure()));
  });

  test(
      'Should return cache failure when the call to local data source is unsuccessful',
      () async {
    when(() => datasource.check()).thenThrow(ServerException(tErrorMessage));

    final response = await repository.check();

    expect(response, Left(ServerFailure(tErrorMessage)));
  });
}
