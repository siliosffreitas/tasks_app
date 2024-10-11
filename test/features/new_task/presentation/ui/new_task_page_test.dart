import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:tasks_app/features/auth/domain/usecases/authentication.dart';

import 'package:tasks_app/features/new_task/domain/usecases/create_task.dart';
import 'package:tasks_app/features/new_task/presentation/presenters/mobx_new_task_presenter.dart';
import 'package:tasks_app/features/new_task/presentation/ui/new_task_page.dart';

class MockMobxNewTaskPresenter extends Mock implements MobxNewTaskPresenter {}

class MockCreateTask extends Mock implements CreateTask {}

void main() {
  setUpAll(() {
    registerFallbackValue(
        const AuthenticationParams(username: '', password: ''));
  });

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
    'Should present error if username is empty',
    (WidgetTester tester) async {
      presenter = MobxNewTaskPresenter(usecase: MockCreateTask());
      await loadPage(tester);

      await tester.enterText(
          find.bySemanticsLabel('Título'), 'siliosffreitas@gmail.com');

      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Título'), '');

      await tester.pump();

      expect(find.text('Título obrigatório'), findsOneWidget);
    },
  );

  testWidgets(
    'Should not present error if username is valid',
    (WidgetTester tester) async {
      presenter = MobxNewTaskPresenter(usecase: MockCreateTask());
      await loadPage(tester);

      await tester.enterText(
          find.bySemanticsLabel('Título'), 'siliosffreitas@gmail.com');

      await tester.pump();

      final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Título'),
        matching: find.byType(Text),
      );
      expect(emailTextChildren, findsOneWidget);
    },
  );

  testWidgets(
    'Should present error if password is empty',
    (WidgetTester tester) async {
      presenter = MobxNewTaskPresenter(usecase: MockCreateTask());
      await loadPage(tester);

      await tester.enterText(find.bySemanticsLabel('Descrição'), 'Silio123\$');
      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Descrição'), '');
      await tester.pump();

      expect(find.text('Descrição obrigatória'), findsOneWidget);
    },
  );

  testWidgets(
    'Should not present error if password is valid',
    (WidgetTester tester) async {
      presenter = MobxNewTaskPresenter(usecase: MockCreateTask());
      await loadPage(tester);

      await tester.enterText(find.bySemanticsLabel('Descrição'), 'Silio123\$');

      await tester.pump();

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
      presenter = MobxNewTaskPresenter(usecase: MockCreateTask());
      await loadPage(tester);

      await tester.enterText(
          find.bySemanticsLabel('Título'), 'siliosffreitas@gmail.com');
      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Descrição'), 'Silio123\$');
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    },
  );

  testWidgets(
    'Should disable form button if form is invalid 3',
    (WidgetTester tester) async {
      presenter = MobxNewTaskPresenter(usecase: MockCreateTask());
      await loadPage(tester);

      await tester.enterText(
          find.bySemanticsLabel('Título'), 'siliosffreitas@gmail.com');
      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Descrição'), 'Silio123\$');
      await tester.pump();

      await tester.enterText(find.bySemanticsLabel('Descrição'), '');
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, null);
    },
  );

  // testWidgets(
  //   'Should present loading',
  //   (WidgetTester tester) async {
  //     presenter = MobxNewTaskPresenter(usecase: MockCreateTask());
  //     await loadPage(tester);

  //     await tester.enterText(
  //         find.bySemanticsLabel('Título'), 'siliosffreitas@gmail.com');
  //     await tester.pump();

  //     await tester.enterText(find.bySemanticsLabel('Descrição'), 'Silio123\$');
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
  //     Authentication u = MockCreateTask();
  //     when(() => u.call(any()))
  //         .thenAnswer((_) async => Right(AccountEntity(accessToken: '')));

  //     presenter = MobxNewTaskPresenter(usecase: u);
  //     await loadPage(tester);

  //     await tester.enterText(
  //         find.bySemanticsLabel('Título'), 'siliosffreitas@gmail.com');
  //     await tester.pump();

  //     await tester.enterText(find.bySemanticsLabel('Descrição'), 'Silio123\$');
  //     await tester.pump();

  //     final okButton = find.text('Entrar');

  //     await tester.tap(okButton);
  //     await tester.pump(Duration.zero);

  //     expect(find.text('Home'), findsOneWidget);
  //   },
  // );
}
