import 'package:flutter_modular/flutter_modular.dart';

import 'features/auth/presentation/presenters/mobx_login_presenter.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<MobxLoginPresenter>((_) => MobxLoginPresenter()),
      ];
}
