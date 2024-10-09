import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/ui/components/coming_soon_page.dart';
import 'features/auth/presentation/presenters/mobx_login_presenter.dart';
import 'features/auth/presentation/ui/login_page.dart';
import 'injection_container.dart';

void main() {
  return runApp(ModularApp(
    module: AppModule(),
    child: MyApp(),
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
        return _buildPage(LoginPage(
          presenter: Modular.get<MobxLoginPresenter>(),
        ));

      default:
        return _buildPage(const ComingSoonPage());
    }
  }

  Route _buildPage(Widget page) =>
      MaterialPageRoute(builder: (context) => page);
}
