import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/ui/components/app_theme.dart';
import 'core/ui/components/coming_soon_page.dart';
import 'features/auth/presentation/presenters/mobx_login_presenter.dart';
import 'features/auth/presentation/ui/login_page.dart';
import 'features/home/presentation/presenters/mobx_home_presenter.dart';
import 'features/home/presentation/ui/home_page.dart';
import 'features/new_task/presentation/presenters/mobx_new_task_presenter.dart';
import 'features/new_task/presentation/ui/new_task_page.dart';
import 'features/signin/presentation/presenters/mobx_signin_presenter.dart';
import 'features/signin/presentation/ui/signin_page.dart';
import 'features/splash/presentation/presenters/mobx_splash_presenter.dart';
import 'features/splash/presentation/ui/splash_page.dart';
import 'features/task/presentation/presenters/mobx_task_presenter.dart';
import 'features/task/presentation/ui/task_page.dart';
import 'injection_container.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    return runApp(ModularApp(
      module: AppModule(),
      child: const MyApp(),
    ));
  }, ((error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  }));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/splash',
      theme: makeDefaultAppTheme,
      onGenerateRoute: _onGenerateRoute,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return _buildPage(
            SplashPage(presenter: Modular.get<MobxSplashPresenter>()));
      case '/login':
        return _buildPage(
            LoginPage(presenter: Modular.get<MobxLoginPresenter>()));
      case '/signin':
        return _buildPage(
            SigninPage(presenter: Modular.get<MobxSigninPresenter>()));

      case '/home':
        return _buildPage(HomePage(
          presenter: Modular.get<MobxHomePresenter>(),
        ));

      case '/new_task':
        return _buildPage(NewTaskPage(
          presenter: Modular.get<MobxNewTaskPresenter>(),
        ));
      case '/task':
        return _buildPage(TaskPage(
          presenter: Modular.get<MobxTaskPresenter>(),
          taskId: settings.arguments as String,
        ));
      default:
        return _buildPage(const ComingSoonPage());
    }
  }

  Route _buildPage(Widget page) =>
      MaterialPageRoute(builder: (context) => page);
}
