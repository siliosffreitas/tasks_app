import 'package:tasks_app/features/auth/domain/entities/index.dart';
import 'package:tasks_app/features/auth/domain/repositories/index.dart';
import 'package:tasks_app/features/auth/domain/usecases/authentication.dart';
import 'package:test/test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:dartz/dartz.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late Authentication usecase;
  late AuthenticationRepository repository;

  late AccountEntity tAccount;
  late String tUsername;
  late String tPassword;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = AuthenticationImp(repository: repository);
    tAccount = AccountEntity(accessToken: faker.guid.guid());
    tUsername = faker.internet.email();
    tPassword = faker.internet.password();
  });

  test('Should get account from the repository', () async {
    when(() => repository.login(any(), any()))
        .thenAnswer((_) async => Right(tAccount));

    final result = await usecase(AuthenticationParams(
      username: tUsername,
      password: tPassword,
    ));

    expect(result, Right(tAccount));
    verify(() => repository.login(tUsername, tPassword)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
