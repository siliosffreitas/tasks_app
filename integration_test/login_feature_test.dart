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

    await tester.tap(find.byType(TextButton));
    await Future.delayed(const Duration(seconds: 1));

    await tester.pumpAndSettle();

    expect(find.text('Crie sua conta fácil'), findsOneWidget);
  }));
}
