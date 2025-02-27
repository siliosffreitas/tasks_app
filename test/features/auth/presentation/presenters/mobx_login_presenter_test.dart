@Timeout(Duration(seconds: 5))
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:dartz/dartz.dart';
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/features/auth/domain/entities/account_entity.dart';
import 'package:tasks_app/features/auth/domain/usecases/authentication.dart';
import 'package:tasks_app/features/auth/presentation/presenters/mobx_login_presenter.dart';

class MockAuthentication extends Mock implements Authentication {}

void main() {
  late MobxLoginPresenter sut;
  late Authentication usecase;
  late String tUsername;
  late String tPassword;
  late AccountEntity tAccount;

  setUpAll(() {
    tUsername = faker.internet.email();
    tPassword = faker.internet.password();
    registerFallbackValue(AuthenticationParams(
      username: tUsername,
      password: tPassword,
    ));
  });

  setUp(() {
    usecase = MockAuthentication();
    sut = MobxLoginPresenter(
      usecase: usecase,
    );

    tAccount = AccountEntity(accessToken: faker.guid.guid());
    when(() => usecase(any())).thenAnswer((_) async => Right(tAccount));
  });

  test(
    'Should emit corret events when validate email success',
    () {
      sut.validateUserName(tUsername);

      expect(sut.username, tUsername);
      expect(sut.usernameError, '');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit corret events when validate email fails empty',
    () {
      sut.validateUserName('');

      expect(sut.username, '');
      expect(sut.usernameError, 'E-mail obrigatório');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit corret events when validate email fails invalid',
    () {
      sut.validateUserName('siliosffreitas');

      expect(sut.username, 'siliosffreitas');
      expect(sut.usernameError, 'E-mail inválido');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit corret events when validate password success',
    () {
      sut.validatePassword(tPassword);

      expect(sut.password, tPassword);
      expect(sut.passwordError, '');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit corret events when validate password fails invalid',
    () {
      sut.validatePassword('');

      expect(sut.password, '');
      expect(sut.passwordError, 'Senha obrigatória');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit isFormValid as true if username and password have no errors',
    () {
      sut.validateUserName(tUsername);
      sut.validatePassword(tPassword);

      expect(sut.isFormValid, true);
    },
  );

  test('Should go to signin page', () {
    sut.goToSigninPage();

    expect(sut.navigateTo, '/signin');
  });

  test(
    'Should call usecase with correct values',
    () async {
      sut.validateUserName(tUsername);

      sut.validatePassword(tPassword);

      await sut.auth();

      verify(() => usecase(
              AuthenticationParams(username: tUsername, password: tPassword)))
          .called(1);
    },
  );

  test(
    'Should emit correct events on usecase invalidCredentialsError',
    () async {
      when(() => usecase(any()))
          .thenAnswer((_) async => const Left(UnauthorizedFailure()));
      sut.validateUserName(tUsername);
      sut.validatePassword(tPassword);

      await sut.auth();

      expect(sut.mainError,
          'Credenciais inválidas, verifique as informações digitadas e tente novamente.');
    },
  );

  test(
    'Should emit correct events on usecase ServerFailure',
    () async {
      when(() => usecase(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Server error')));

      sut.validateUserName(tUsername);
      sut.validatePassword(tPassword);

      await sut.auth();

      expect(sut.mainError, 'Server error');
    },
  );

  test(
    'Should change page on usecase success',
    () async {
      sut.validateUserName(tUsername);
      sut.validatePassword(tPassword);

      await sut.auth();

      expect(sut.navigateTo, '/home');
    },
  );

  // teste adicionado apenas para que os arquivos gerados do MobX
// TAMBÉM tenham cobertura completa
  test('Should return string', () {
    expect(sut.toString(), '''
isLoading: ${sut.isLoading},
mainError: ${sut.mainError},
navigateTo: ${sut.navigateTo},
username: ${sut.username},
password: ${sut.password},
usernameError: ${sut.usernameError},
passwordError: ${sut.passwordError},
isFormValid: ${sut.isFormValid}
    ''');
  });
}
