import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:tasks_app/features/signin/presentation/presenters/mobx_signin_presenter.dart';
import 'package:tasks_app/features/signin/presentation/ui/signin_page.dart';

class MockMobxSigninPresenter extends Mock implements MobxSigninPresenter {
  MockMobxSigninPresenter() {
    authCall();
  }

  When _authCall() => when(() => auth());
  void authCall() => _authCall().thenAnswer((_) async => _);
}

void main() {
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
      when(() => presenter.usernameError).thenReturn('any error');
      await loadPage(tester);

      expect(find.text('any error'), findsOneWidget);
    },
  );

  testWidgets(
    'Should present no error if username valid (error null)',
    (WidgetTester tester) async {
      when(() => presenter.usernameError).thenReturn(null);
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('E-mail'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should presents no error if username valid (error empty)',
    (WidgetTester tester) async {
      when(() => presenter.usernameError).thenReturn('');
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('E-mail'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should present error if password is invalid',
    (WidgetTester tester) async {
      when(() => presenter.passwordError).thenReturn('any error');
      await loadPage(tester);

      expect(find.text('any error'), findsOneWidget);
    },
  );

  testWidgets(
    'Should present no error if password valid (error null)',
    (WidgetTester tester) async {
      when(() => presenter.passwordError).thenReturn(null);
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should presents no error if password valid (error empty)',
    (WidgetTester tester) async {
      when(() => presenter.passwordError).thenReturn('');
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should present error if confirmation is invalid',
    (WidgetTester tester) async {
      when(() => presenter.passwordConfirmationError).thenReturn('any error');
      await loadPage(tester);

      expect(find.text('any error'), findsOneWidget);
    },
  );

  testWidgets(
    'Should present no error if confirmation valid (error null)',
    (WidgetTester tester) async {
      when(() => presenter.passwordConfirmationError).thenReturn(null);
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Confirmação da Senha'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should presents no error if confirmation valid (error empty)',
    (WidgetTester tester) async {
      when(() => presenter.passwordConfirmationError).thenReturn('');
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Confirmação da Senha'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should enable form button if form is valid',
    (WidgetTester tester) async {
      when(() => presenter.isFormValid).thenReturn(true);
      await loadPage(tester);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    },
  );

  testWidgets(
    'Should disable form button if form is invalid',
    (WidgetTester tester) async {
      when(() => presenter.isFormValid).thenReturn(false);
      await loadPage(tester);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, null);
    },
  );
  testWidgets(
    'Should present loading',
    (WidgetTester tester) async {
      when(() => presenter.isLoading).thenReturn(true);

      await loadPage(tester);

      await tester.pump(Duration.zero);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Should hide loading',
    (WidgetTester tester) async {
      when(() => presenter.isLoading).thenReturn(false);

      await loadPage(tester);

      await tester.pump(Duration.zero);

      expect(find.byType(CircularProgressIndicator), findsNothing);
    },
  );

  testWidgets(
    'Should call authentication on form submit',
    (WidgetTester tester) async {
      when(() => presenter.isFormValid).thenReturn(true);
      await loadPage(tester);

      final button = find.byType(ElevatedButton);

      await tester.ensureVisible(button);

      await tester.tap(button);
      await tester.pump();

      verify(() => presenter.auth()).called(1);
    },
  );

  testWidgets(
    'Should go to explanation',
    (WidgetTester tester) async {
      await loadPage(tester);

      final button = find.byIcon(Icons.help);
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();

      verify(() => presenter.goPasswordStrongExplanation()).called(1);
    },
  );
}
