import 'package:flutter_modular/flutter_modular.dart';
import 'package:tasks_app/features/auth/presentation/ui/login_page.dart';

import 'features/auth/presentation/presenters/mobx_login_presenter.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<MobxLoginPresenter>((_) => MobxLoginPresenter()),
      ];

  @override
  List<ModularRoute> get routes => [
        // ChildRoute(
        //   '/',
        //   child: (context, args) => LoginPage(
        //     presenter: Modular.get<MobxLoginPresenter>(),
        //   ),
        // ),
      ];
}
