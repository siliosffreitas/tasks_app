import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:tasks_app/features/splash/presentation/presenters/mobx_splash_presenter.dart';
import 'package:tasks_app/features/splash/presentation/ui/splash_page.dart';

class MockMobxSplashPresenter extends Mock implements MobxSplashPresenter {
  MockMobxSplashPresenter() {
    checkLoggedUserCall();
  }
  When _loadCheckLoggedUserCall() => when(() => checkLoggedUser());
  void checkLoggedUserCall() =>
      _loadCheckLoggedUserCall().thenAnswer((_) async => _);
}

void main() {
  late MobxSplashPresenter presenter;

  setUp(() {
    presenter = MockMobxSplashPresenter();
  });

  Future<void> loadPage(WidgetTester tester) async {
    final page = MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) {
          return SplashPage(
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

      verify(() => presenter.checkLoggedUser()).called(1);
    },
  );
}
