import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:tasks_app/features/auth/domain/entities/index.dart';
import 'package:tasks_app/features/auth/domain/usecases/authentication.dart';
import 'package:tasks_app/features/auth/presentation/presenters/mobx_login_presenter.dart';
import 'package:tasks_app/features/auth/presentation/ui/login_page.dart';

class MockMobxLoginPresenter extends Mock implements MobxLoginPresenter {}

class MockAuthentication extends Mock implements Authentication {}

void main() {
  setUpAll(() {
    registerFallbackValue(AuthenticationParams(username: '', password: ''));
  });

  late MobxLoginPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    final loginPage = MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(presenter: presenter),
        '/home': (context) => Scaffold(
              body: Center(
                child: Text('Home'),
              ),
            )
      },
    );
    await tester.pumpWidget(loginPage);
  }

  testWidgets(
    'Should load with correct initial state',
    (WidgetTester tester) async {
      presenter = MockMobxLoginPresenter();
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

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, null);
    },
  );

  testWidgets(
    'Should call validate with correct values',
    (WidgetTester tester) async {
      presenter = MockMobxLoginPresenter();
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
    },
  );

  testWidgets(
    'Should present error if username is invalid',
    (WidgetTester tester) async {
      presenter = MobxLoginPresenter(usecase: MockAuthentication());
      await loadPage(tester);

      await tester.enterText(find.bySemanticsLabel('E-mail'), 'silio');

      await tester.pump();

      expect(find.text('E-mail inválido'), findsOneWidget);
    },
  );

  testWidgets(
    'Should present error if username is empty',
    (WidgetTester tester) async {
      presenter = MobxLoginPresenter(usecase: MockAuthentication());
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
      presenter = MobxLoginPresenter(usecase: MockAuthentication());
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
      presenter = MobxLoginPresenter(usecase: MockAuthentication());
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
      presenter = MobxLoginPresenter(usecase: MockAuthentication());
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
    'Should enable form button if form is valid',
    (WidgetTester tester) async {
      presenter = MobxLoginPresenter(usecase: MockAuthentication());
      await loadPage(tester);

      await tester.enterText(
          find.bySemanticsLabel('E-mail'), 'siliosffreitas@gmail.com');
      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Senha'), 'Silio123\$');
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    },
  );

  testWidgets(
    'Should disable form button if form is invalid 2',
    (WidgetTester tester) async {
      presenter = MobxLoginPresenter(usecase: MockAuthentication());
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
      presenter = MobxLoginPresenter(usecase: MockAuthentication());
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
  //     presenter = MobxLoginPresenter(usecase: MockAuthentication());
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
  //     Authentication u = MockAuthentication();
  //     when(() => u.call(any()))
  //         .thenAnswer((_) async => Right(AccountEntity(accessToken: '')));

  //     presenter = MobxLoginPresenter(usecase: u);
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
