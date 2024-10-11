import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/core/usecases/usecase.dart';
import 'package:tasks_app/features/auth/domain/entities/account_entity.dart';
import 'package:tasks_app/features/splash/domain/usecases/check_has_logged_user.dart';
import 'package:tasks_app/features/splash/presentation/presenters/mobx_splash_presenter.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:dartz/dartz.dart';

class MockCheckHasLoggedUser extends Mock implements CheckHasLoggedUser {}

void main() {
  late MobxSplashPresenter sut;
  late CheckHasLoggedUser usecase;
  late AccountEntity tAccount;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    usecase = MockCheckHasLoggedUser();
    sut = MobxSplashPresenter(
      usecase,
    );
    tAccount = AccountEntity(accessToken: faker.guid.guid());

    when(() => usecase(any())).thenAnswer((_) async => Right(tAccount));
  });

  test(
    'Should call usecase with correct values',
    () async {
      await sut.checkLoggedUser();

      verify(() => usecase(NoParams())).called(1);
    },
  );

  test(
    'Should change page on usecase success',
    () async {
      await sut.checkLoggedUser();

      expect(sut.navigateTo, '/home');
    },
  );

  test(
    'Should show login page when has no logged user',
    () async {
      when(() => usecase(any())).thenAnswer((_) async => const Right(null));
      await sut.checkLoggedUser();

      expect(sut.navigateTo, '/login');
    },
  );

  test(
    'Should show login page when usecase fails',
    () async {
      when(() => usecase(any()))
          .thenAnswer((_) async => const Left(CacheFailure()));
      await sut.checkLoggedUser();

      expect(sut.navigateTo, '/login');
    },
  );

  // teste adicionado apenas para que os arquivos gerados do MobX
  // TAMBÉM tenham cobertura completa
  test('Should return string', () {
    expect(sut.toString(), '''
navigateTo: ${sut.navigateTo}
    ''');
  });
}
