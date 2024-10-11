@Timeout(Duration(seconds: 5))
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:dartz/dartz.dart';
import 'package:tasks_app/core/error/failures.dart';
import 'package:tasks_app/features/auth/domain/entities/index.dart';
import 'package:tasks_app/features/signin/domain/usecases/add_account.dart';
import 'package:tasks_app/features/signin/presentation/presenters/mobx_signin_presenter.dart';

class MockAddAccount extends Mock implements AddAccount {}

void main() {
  late MobxSigninPresenter sut;
  late AddAccount usecase;
  late String tUsername;
  late String tPassword;
  late AccountEntity tAccount;

  setUpAll(() {
    tUsername = faker.internet.email();
    tPassword = 'Silio123\$';
    registerFallbackValue(AddAccountParams(
      username: tUsername,
      password: tPassword,
    ));
  });

  setUp(() {
    usecase = MockAddAccount();
    sut = MobxSigninPresenter(
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
    'Should emit corret events when validate password fails empty',
    () {
      sut.validatePassword('');

      expect(sut.password, '');
      expect(sut.passwordError, 'Senha obrigatória');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit corret events when validate password fails invalid',
    () {
      sut.validatePassword('12345');

      expect(sut.password, '12345');
      expect(sut.passwordError, 'Senha fraca');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit corret events when validate confirmation fails empty',
    () {
      sut.validatePasswordConfirmation('');

      expect(sut.passwordConfirmation, '');
      expect(sut.passwordConfirmationError, 'Confirmação obrigatória');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit corret events when validate confirmation fails invalid',
    () {
      sut.validatePassword('Silio123#');
      sut.validatePasswordConfirmation('Silio123');

      expect(sut.passwordConfirmation, 'Silio123');
      expect(sut.passwordConfirmationError, 'Confirmação errada');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit corret events when validate confirmation ',
    () {
      sut.validatePassword('Silio123#');
      sut.validatePasswordConfirmation('Silio123#');

      expect(sut.passwordConfirmation, 'Silio123#');
      expect(sut.passwordConfirmationError, '');
      expect(sut.isFormValid, false);
    },
  );

  test(
    'Should emit isFormValid as true if username and password have no errors',
    () {
      sut.validateUserName(tUsername);
      sut.validatePassword(tPassword);
      sut.validatePasswordConfirmation(tPassword);

      expect(sut.isFormValid, true);
    },
  );

  test(
    'Should call usecase with correct values',
    () async {
      sut.validateUserName(tUsername);
      sut.validatePassword(tPassword);
      sut.validatePasswordConfirmation(tPassword);

      await sut.auth();

      verify(() => usecase(
              AddAccountParams(username: tUsername, password: tPassword)))
          .called(1);
    },
  );

  test(
    'Should emit correct events on authentication invalidCredentialsError',
    () async {
      when(() => usecase(any()))
          .thenAnswer((_) async => const Left(UnauthorizedFailure()));
      sut.validateUserName(tUsername);
      sut.validatePassword(tPassword);
      sut.validatePasswordConfirmation(tPassword);

      await sut.auth();

      expect(sut.mainError,
          'Credenciais inválidas, verifique as informações digitadas e tente novamente.');
    },
  );

  test(
    'Should emit correct events on authentication ServerFailure',
    () async {
      when(() => usecase(any()))
          .thenAnswer((_) async => const Left(ServerFailure('Server error')));

      sut.validateUserName(tUsername);
      sut.validatePassword(tPassword);
      sut.validatePasswordConfirmation(tPassword);

      await sut.auth();

      expect(sut.mainError, 'Server error');
    },
  );

  test(
    'Should change page on authentication success',
    () async {
      sut.validateUserName(tUsername);
      sut.validatePassword(tPassword);

      await sut.auth();

      expect(sut.navigateTo, '/success');
    },
  );

  test('Should go to signin page', () {
    sut.goHome();

    expect(sut.navigateTo, '/home');
  });

  test('Should show explanation password', () {
    sut.goPasswordStrongExplanation();

    expect(sut.navigateTo, '/how_get_strong_password');
  });

// teste adicionado apenas para que os arquivos gerados do MobX
// TAMBÉM tenham cobertura completa

  test('Should return string', () {
    expect(sut.toString(), '''
isLoading: ${sut.isLoading},
mainError: ${sut.mainError},
navigateTo: ${sut.navigateTo},
username: ${sut.username},
password: ${sut.password},
passwordConfirmation: ${sut.passwordConfirmation},
usernameError: ${sut.usernameError},
passwordError: ${sut.passwordError},
passwordConfirmationError: ${sut.passwordConfirmationError},
isFormValid: ${sut.isFormValid}
    ''');
  });
}
