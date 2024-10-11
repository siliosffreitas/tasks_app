import 'package:tasks_app/core/usecases/usecase.dart';
import 'package:tasks_app/features/auth/domain/entities/account_entity.dart';
import 'package:tasks_app/features/splash/domain/repositories/check_has_logged_user_repository.dart';
import 'package:tasks_app/features/splash/domain/usecases/check_has_logged_user.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';

class MockCheckHasLoggedUserRepository extends Mock
    implements CheckHasLoggedUserRepository {}

void main() {
  late CheckHasLoggedUser usecase;
  late CheckHasLoggedUserRepository repository;
  late AccountEntity tAccount;

  setUp(() {
    repository = MockCheckHasLoggedUserRepository();
    usecase = CheckHasLoggedUserImp(repository: repository);
    tAccount = AccountEntity(accessToken: faker.guid.guid());

    when(() => repository.check()).thenAnswer((_) async => Right(tAccount));
  });

  test('Should call load from the repository', () async {
    final result = await usecase(NoParams());

    verify(() => repository.check()).called(1);
    expect(result, Right(tAccount));
    verifyNoMoreInteractions(repository);
  });
}
