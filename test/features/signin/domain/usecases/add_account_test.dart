import 'package:tasks_app/features/auth/domain/entities/index.dart';
import 'package:tasks_app/features/signin/domain/repositories/add_account_repository.dart';
import 'package:tasks_app/features/signin/domain/usecases/add_account.dart';
import 'package:test/test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:dartz/dartz.dart';

class MockAddAccountRepository extends Mock implements AddAccountRepository {}

void main() {
  late AddAccount usecase;
  late AddAccountRepository repository;

  late AccountEntity tAccount;
  late String tUsername;
  late String tPassword;

  setUp(() {
    repository = MockAddAccountRepository();
    usecase = AddAccountImp(repository: repository);
    tAccount = AccountEntity(accessToken: faker.guid.guid());
    tUsername = faker.internet.email();
    tPassword = faker.internet.password();
  });

  test('Should get account from the repository', () async {
    when(() => repository.signin(any(), any()))
        .thenAnswer((_) async => Right(tAccount));

    final result = await usecase(AddAccountParams(
      username: tUsername,
      password: tPassword,
    ));

    expect(result, Right(tAccount));
    verify(() => repository.signin(tUsername, tPassword)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
