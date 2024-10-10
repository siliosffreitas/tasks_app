import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/ui/components/app_theme.dart';

import 'injection_container.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    return runApp(ModularApp(
      module: AppModule(),
      child: MyApp(),
    ));
  }, ((error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  }));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {
    Modular.setInitialRoute('/splash');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: makeDefaultAppTheme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
