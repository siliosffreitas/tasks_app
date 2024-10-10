import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasks_app/features/auth/presentation/presenters/mobx_login_presenter.dart';
import 'package:tasks_app/features/auth/presentation/ui/login_page.dart';

class MockMobxLoginPresenter extends Mock implements MobxLoginPresenter {}

void main() {
  late MobxLoginPresenter presenter;
  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockMobxLoginPresenter();

    final loginPage = MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(presenter: presenter),
      },
    );
    await tester.pumpWidget(loginPage);
  }

  testWidgets(
    'Should load with correct initial state',
    (WidgetTester tester) async {
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
}
