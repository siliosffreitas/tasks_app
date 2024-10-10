import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/ui/components/coming_soon_page.dart';
import 'features/auth/presentation/presenters/mobx_login_presenter.dart';
import 'features/auth/presentation/ui/login_page.dart';
import 'features/home/presentation/ui/home_page.dart';
import 'features/signin/presentation/presenters/mobx_signin_presenter.dart';
import 'features/signin/presentation/ui/signin_page.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(ModularApp(
    module: AppModule(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _onGenerateRoute,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return _buildPage(
            LoginPage(presenter: Modular.get<MobxLoginPresenter>()));
      case '/signin':
        return _buildPage(
            SigninPage(presenter: Modular.get<MobxSigninPresenter>()));

      case '/home':
        return _buildPage(HomePage());

      default:
        return _buildPage(const ComingSoonPage());
    }
  }

  Route _buildPage(Widget page) =>
      MaterialPageRoute(builder: (context) => page);
}
