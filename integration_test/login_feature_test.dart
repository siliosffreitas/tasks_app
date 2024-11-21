import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tasks_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Should present Create account page com button click',
      ((WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final button = find.byType(TextButton);

    await tester.drag(
        find.byType(SingleChildScrollView), const Offset(0.0, -300));
    await tester.pump();

    await tester.ensureVisible(button);

    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.tap(button);

    await tester.pumpAndSettle();

    expect(find.text('Crie sua conta fácil'), findsOneWidget);
  }));

  testWidgets('Should login with success', ((WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.enterText(
        find.bySemanticsLabel('E-mail'), 'siliosffreitas@gmail.com');
    await tester.enterText(find.bySemanticsLabel('Senha'), 'Silio123\$');

    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('Tarefas'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.exit_to_app));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sim'));
    await tester.pumpAndSettle();

    expect(find.text('Bem-vindo ao Lista de tarefas by Silio'), findsOneWidget);
  }));

  testWidgets('Should login with fails', ((WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.enterText(
        find.bySemanticsLabel('E-mail'), 'invalid@email.com');
    await tester.enterText(find.bySemanticsLabel('Senha'), 'invalid_pass');

    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('Tarefas'), findsNothing);
    expect(find.text('Atenção'), findsOneWidget);
  }));
}
