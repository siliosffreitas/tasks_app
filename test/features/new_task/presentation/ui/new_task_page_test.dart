import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:tasks_app/features/new_task/presentation/presenters/mobx_new_task_presenter.dart';
import 'package:tasks_app/features/new_task/presentation/ui/new_task_page.dart';

class MockMobxNewTaskPresenter extends Mock implements MobxNewTaskPresenter {
  MockMobxNewTaskPresenter() {
    createTaskCall();
  }

  When _createTaskCall() => when(() => createTask());
  void createTaskCall() => _createTaskCall().thenAnswer((_) async => _);
}

void main() {
  late MobxNewTaskPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    final loginPage = MaterialApp(
      initialRoute: '/new_task',
      routes: {
        '/new_task': (context) => NewTaskPage(presenter: presenter),
      },
    );
    await tester.pumpWidget(loginPage);
  }

  testWidgets(
    'Should load with correct initial state',
    (WidgetTester tester) async {
      presenter = MockMobxNewTaskPresenter();
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Título'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);

      final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Descrição'),
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
      presenter = MockMobxNewTaskPresenter();
      await loadPage(tester);

      final username = faker.internet.email();
      await tester.enterText(find.bySemanticsLabel('Título'), username);

      verify(() => presenter.validateTitle(username));

      final password = faker.internet.password();
      await tester.enterText(
        find.bySemanticsLabel('Descrição'),
        password,
      );

      verify(() => presenter.validateDescription(password));
    },
  );

  testWidgets(
    'Should present error if username is invalid',
    (WidgetTester tester) async {
      when(() => presenter.titleError).thenReturn('any error');
      await loadPage(tester);

      expect(find.text('any error'), findsOneWidget);
    },
  );

  testWidgets(
    'Should present no error if username valid (error null)',
    (WidgetTester tester) async {
      when(() => presenter.titleError).thenReturn(null);
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Título'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should presents no error if username valid (error empty)',
    (WidgetTester tester) async {
      when(() => presenter.titleError).thenReturn('');
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Título'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should present error if password is invalid',
    (WidgetTester tester) async {
      when(() => presenter.descriptionError).thenReturn('any error');
      await loadPage(tester);

      expect(find.text('any error'), findsOneWidget);
    },
  );

  testWidgets(
    'Should present no error if password valid (error null)',
    (WidgetTester tester) async {
      when(() => presenter.descriptionError).thenReturn(null);
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Descrição'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should presents no error if password valid (error empty)',
    (WidgetTester tester) async {
      when(() => presenter.descriptionError).thenReturn('');
      await loadPage(tester);

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Descrição'),
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

      verify(() => presenter.createTask()).called(1);
    },
  );

  testWidgets(
    'Should present error',
    (WidgetTester tester) async {
      when(() => presenter.mainError).thenReturn('any error');

      await loadPage(tester);

      await tester.pump(Duration.zero);

      expect(find.text('any error'), findsOneWidget);

      final button = find.text('OK');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();

      expect(find.text('any error'), findsNothing);
    },
  );
}
