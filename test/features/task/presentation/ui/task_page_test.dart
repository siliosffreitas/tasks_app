import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:tasks_app/features/home/presentation/ui/task_viewmodel.dart';
import 'package:tasks_app/features/task/presentation/presenters/mobx_task_presenter.dart';
import 'package:tasks_app/features/task/presentation/ui/task_page.dart';

class MockMobxTaskPresenter extends Mock implements MobxTaskPresenter {
  MockMobxTaskPresenter() {
    loadTaskCall();
  }
  When _loadTaskCall() => when(() => loadTask(any()));
  void loadTaskCall() => _loadTaskCall().thenAnswer((_) async => _);
}

void main() {
  late MobxTaskPresenter presenter;
  late String taskId;
  late TaskViewmodel task;

  setUp(() {
    presenter = MockMobxTaskPresenter();
    taskId = faker.guid.guid();
    task = TaskViewmodel(
      id: faker.guid.guid(),
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
    );
  });

  Future<void> loadPage(WidgetTester tester) async {
    final page = MaterialApp(
      initialRoute: '/task_page',
      routes: {
        '/task_page': (context) {
          return TaskPage(
            presenter: presenter,
            taskId: taskId,
          );
        },
      },
    );

    await tester.pumpWidget(page);
  }

  testWidgets(
    'Should call LoadTask on page load',
    (WidgetTester tester) async {
      await loadPage(tester);

      verify(() => presenter.loadTask(taskId)).called(1);
    },
  );

  testWidgets(
    'Should present error if get task fails',
    (WidgetTester tester) async {
      when(() => presenter.mainError).thenReturn('main error');
      await loadPage(tester);

      expect(find.text('main error'), findsOneWidget);
      expect(find.text('Recarregar'), findsOneWidget);
      expect(find.text('Título:'), findsNothing);
    },
  );

  testWidgets(
    'Should present nothing if has no error but has no result',
    (WidgetTester tester) async {
      await loadPage(tester);

      expect(find.text('Título:'), findsNothing);
    },
  );

  testWidgets(
    'Should call LoadApprentice on try again click',
    (WidgetTester tester) async {
      when(() => presenter.mainError).thenReturn('main error');
      await loadPage(tester);

      final tryAgainButton = find.text('Recarregar');

      await tester.tap(tryAgainButton);

      verify(() => presenter.loadTask(taskId)).called(2);
    },
  );

  testWidgets(
    'Should present apprendice if get task succeeds',
    (WidgetTester tester) async {
      when(() => presenter.task).thenReturn(task);
      await loadPage(tester);

      expect(
        find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsNothing,
      );
      expect(find.text('Recarregar'), findsNothing);

      expect(find.text('Título:'), findsOneWidget);
      expect(find.text(task.title), findsOneWidget);
      expect(find.text('Descrição:'), findsOneWidget);
      expect(find.text(task.description), findsOneWidget);
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
