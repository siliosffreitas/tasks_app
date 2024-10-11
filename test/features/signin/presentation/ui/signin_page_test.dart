import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:tasks_app/features/auth/domain/usecases/authentication.dart';
import 'package:tasks_app/features/signin/domain/usecases/add_account.dart';
import 'package:tasks_app/features/signin/presentation/presenters/mobx_signin_presenter.dart';
import 'package:tasks_app/features/signin/presentation/ui/signin_page.dart';

class MockMobxSigninPresenter extends Mock implements MobxSigninPresenter {}

class MockAddAccount extends Mock implements AddAccount {}

void main() {
  setUpAll(() {
    registerFallbackValue(
        const AuthenticationParams(username: '', password: ''));
  });

  late MobxSigninPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    final loginPage = MaterialApp(
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => SigninPage(presenter: presenter),
      },
    );
    await tester.pumpWidget(loginPage);
  }

  testWidgets(
    'Should load with correct initial state',
    (WidgetTester tester) async {
      presenter = MockMobxSigninPresenter();
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('E-mail'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);

      final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'),
        matching: find.byType(Text),
      );
      expect(passwordTextChildren, findsOneWidget);

      final confirmationTextChildren = find.descendant(
        of: find.bySemanticsLabel('Confirmação da Senha'),
        matching: find.byType(Text),
      );
      expect(confirmationTextChildren, findsOneWidget);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, null);
    },
  );

  testWidgets(
    'Should call validate with correct values',
    (WidgetTester tester) async {
      presenter = MockMobxSigninPresenter();
      await loadPage(tester);

      final username = faker.internet.email();
      await tester.enterText(find.bySemanticsLabel('E-mail'), username);

      verify(() => presenter.validateUserName(username));

      final password = faker.internet.password();
      await tester.enterText(
        find.bySemanticsLabel('Senha'),
        password,
      );

      verify(() => presenter.validatePassword(password));

      final confirmation = faker.internet.password();
      await tester.enterText(
        find.bySemanticsLabel('Confirmação da Senha'),
        confirmation,
      );

      verify(() => presenter.validatePasswordConfirmation(confirmation));
    },
  );

  testWidgets(
    'Should present error if username is invalid',
    (WidgetTester tester) async {
      presenter = MobxSigninPresenter(usecase: MockAddAccount());
      await loadPage(tester);

      await tester.enterText(find.bySemanticsLabel('E-mail'), 'silio');

      await tester.pump();

      expect(find.text('E-mail inválido'), findsOneWidget);
    },
  );

  testWidgets(
    'Should present error if username is empty',
    (WidgetTester tester) async {
      presenter = MobxSigninPresenter(usecase: MockAddAccount());
      await loadPage(tester);

      await tester.enterText(
          find.bySemanticsLabel('E-mail'), 'siliosffreitas@gmail.com');

      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('E-mail'), '');

      await tester.pump();

      expect(find.text('E-mail obrigatório'), findsOneWidget);
    },
  );

  testWidgets(
    'Should not present error if username is valid',
    (WidgetTester tester) async {
      presenter = MobxSigninPresenter(usecase: MockAddAccount());
      await loadPage(tester);

      await tester.enterText(
          find.bySemanticsLabel('E-mail'), 'siliosffreitas@gmail.com');

      await tester.pump();

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('E-mail'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should present error if password is empty',
    (WidgetTester tester) async {
      presenter = MobxSigninPresenter(usecase: MockAddAccount());
      await loadPage(tester);

      await tester.enterText(find.bySemanticsLabel('Senha'), 'Silio123\$');
      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Senha'), '');
      await tester.pump();

      expect(find.text('Senha obrigatória'), findsOneWidget);
    },
  );

  testWidgets(
    'Should not present error if password is valid',
    (WidgetTester tester) async {
      presenter = MobxSigninPresenter(usecase: MockAddAccount());
      await loadPage(tester);

      await tester.enterText(find.bySemanticsLabel('Senha'), 'Silio123\$');

      await tester.pump();

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should present error if confirmation is empty',
    (WidgetTester tester) async {
      presenter = MobxSigninPresenter(usecase: MockAddAccount());
      await loadPage(tester);

      await tester.enterText(
          find.bySemanticsLabel('Confirmação da Senha'), 'Silio123\$');
      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Confirmação da Senha'), '');
      await tester.pump();

      expect(find.text('Confirmação obrigatória'), findsOneWidget);
    },
  );

  testWidgets(
    'Should enable form button if form is valid',
    (WidgetTester tester) async {
      presenter = MobxSigninPresenter(usecase: MockAddAccount());
      await loadPage(tester);

      await tester.enterText(
          find.bySemanticsLabel('E-mail'), 'siliosffreitas@gmail.com');
      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Senha'), 'Silio123\$');
      await tester.pump();

      await tester.enterText(
          find.bySemanticsLabel('Confirmação da Senha'), 'Silio123\$');
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    },
  );

  testWidgets(
    'Should disable form button if form is invalid 2',
    (WidgetTester tester) async {
      presenter = MobxSigninPresenter(usecase: MockAddAccount());
      await loadPage(tester);

      await tester.enterText(find.bySemanticsLabel('E-mail'), 'siliosffreitas');
      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Senha'), 'Silio123\$');
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, null);
    },
  );

  testWidgets(
    'Should disable form button if form is invalid 3',
    (WidgetTester tester) async {
      presenter = MobxSigninPresenter(usecase: MockAddAccount());
      await loadPage(tester);

      await tester.enterText(
          find.bySemanticsLabel('E-mail'), 'siliosffreitas@gmail.com');
      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Senha'), 'Silio123\$');
      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Senha'), '');
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, null);
    },
  );

  // testWidgets(
  //   'Should present loading',
  //   (WidgetTester tester) async {
  //     presenter = MobxSigninPresenter(usecase: MockAddAccount());
  //     await loadPage(tester);

  //     await tester.enterText(
  //         find.bySemanticsLabel('E-mail'), 'siliosffreitas@gmail.com');
  //     await tester.pump();

  //     await tester.enterText(find.bySemanticsLabel('Senha'), 'Silio123\$');
  //     await tester.pump();

  //     final okButton = find.text('Entrar');

  //     await tester.tap(okButton);

  //     await tester.pump(Duration.zero);

  //     expect(find.byType(CircularProgressIndicator), findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   'Should change page',
  //   (WidgetTester tester) async {
  //     Authentication u = MockAddAccount();
  //     when(() => u.call(any()))
  //         .thenAnswer((_) async => Right(AccountEntity(accessToken: '')));

  //     presenter = MobxSigninPresenter(usecase: u);
  //     await loadPage(tester);

  //     await tester.enterText(
  //         find.bySemanticsLabel('E-mail'), 'siliosffreitas@gmail.com');
  //     await tester.pump();

  //     await tester.enterText(find.bySemanticsLabel('Senha'), 'Silio123\$');
  //     await tester.pump();

  //     final okButton = find.text('Entrar');

  //     await tester.tap(okButton);
  //     await tester.pump(Duration.zero);

  //     expect(find.text('Home'), findsOneWidget);
  //   },
  // );
}
