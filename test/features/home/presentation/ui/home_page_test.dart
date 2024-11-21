import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:tasks_app/features/home/presentation/presenters/mobx_home_presenter.dart';
import 'package:tasks_app/features/home/presentation/ui/home_page.dart';
import 'package:tasks_app/features/home/presentation/ui/task_viewmodel.dart';

class MockMobxHomePresenter extends Mock implements MobxHomePresenter {
  MockMobxHomePresenter() {
    loadTaskCall();
  }
  When _loadTaskCall() => when(() => loadTasks());
  void loadTaskCall() => _loadTaskCall().thenAnswer((_) async => _);
}

void main() {
  late MobxHomePresenter presenter;
  late List<TaskViewmodel> tasks;

  setUp(() {
    presenter = MockMobxHomePresenter();

    tasks = [
      TaskViewmodel(
        id: faker.guid.guid(),
        title: faker.lorem.sentence(),
        description: faker.lorem.sentence(),
      ),
      TaskViewmodel(
        id: faker.guid.guid(),
        title: faker.lorem.sentence() + faker.lorem.sentence(),
        description: faker.lorem.sentence(),
      ),
    ];
  });

  Future<void> loadPage(WidgetTester tester) async {
    final page = MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) {
          return HomePage(
            presenter: presenter,
          );
        },
      },
    );

    await tester.pumpWidget(page);
  }

  testWidgets(
    'Should call LoadTasks on page load',
    (WidgetTester tester) async {
      await loadPage(tester);

      verify(() => presenter.loadTasks()).called(1);
    },
  );

  testWidgets(
    'Should present error if get tasks fails',
    (WidgetTester tester) async {
      when(() => presenter.mainError).thenReturn('main error');
      await loadPage(tester);

      expect(find.text('main error'), findsOneWidget);
      expect(find.text('Recarregar'), findsOneWidget);
      expect(find.text(tasks.first.title), findsNothing);
    },
  );

  testWidgets(
    'Should call Loadtasks on try again click',
    (WidgetTester tester) async {
      when(() => presenter.mainError).thenReturn('main error');
      await loadPage(tester);

      final tryAgainButton = find.text('Recarregar');

      await tester.tap(tryAgainButton);

      verify(() => presenter.loadTasks()).called(2);
    },
  );

  testWidgets(
    'Should present apprendice if get task succeeds',
    (WidgetTester tester) async {
      when(() => presenter.tasks).thenReturn(tasks);
      await loadPage(tester);

      expect(
        find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsNothing,
      );
      expect(find.text('Recarregar'), findsNothing);

      expect(find.text(tasks[0].title), findsOneWidget);
      expect(find.text(tasks[0].description), findsOneWidget);
      expect(find.text(tasks[1].title), findsOneWidget);
      expect(find.text(tasks[1].description), findsOneWidget);
    },
  );

  testWidgets(
    'Should call when click in a task',
    (WidgetTester tester) async {
      when(() => presenter.tasks).thenReturn(tasks);
      await loadPage(tester);

      final workoutButton = find.text(tasks[0].title);

      await tester.tap(workoutButton);

      verify(() => presenter.goToTaskPage(tasks[0].id)).called(1);
    },
  );

  testWidgets(
    'Should present message when tasks is empty',
    (WidgetTester tester) async {
      when(() => presenter.tasks).thenReturn([]);
      await loadPage(tester);

      expect(
        find.text('Nenhuma tarefa adicionada, adicione agora'),
        findsOneWidget,
      );
      expect(find.text('Adicionar nova tarefa'), findsOneWidget);
    },
  );

  testWidgets(
    'Should call metod to add task when tasks is empty',
    (WidgetTester tester) async {
      when(() => presenter.tasks).thenReturn([]);
      await loadPage(tester);

      final tryAgainButton = find.text('Adicionar nova tarefa');

      await tester.tap(tryAgainButton);

      verify(() => presenter.goToNewTaskPage()).called(1);
    },
  );

  testWidgets(
    'Should call method to add task ',
    (WidgetTester tester) async {
      await loadPage(tester);

      final tryAgainButton = find.byIcon(Icons.add);

      await tester.tap(tryAgainButton);

      verify(() => presenter.goToNewTaskPage()).called(1);
    },
  );

  testWidgets(
    'Should call method to show logout confirmation ',
    (WidgetTester tester) async {
      await loadPage(tester);

      final tryAgainButton = find.byIcon(Icons.exit_to_app);

      await tester.tap(tryAgainButton);

      verify(() => presenter.showConfirmationLogout()).called(1);
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
}
