import 'package:mobx/mobx.dart';
import '../../../../core/usecases/usecase.dart';

import '../../domain/usecases/check_has_logged_user.dart';

part 'mobx_splash_presenter.g.dart';

class MobxSplashPresenter = _MobxSplashPresenter with _$MobxSplashPresenter;

abstract class _MobxSplashPresenter with Store {
  final CheckHasLoggedUser usecase;

  @observable
  String? navigateTo;

  _MobxSplashPresenter(this.usecase);

  @action
  Future<void> checkLoggedUser() async {
    await Future.delayed(const Duration(seconds: 2));
    final value = await usecase(NoParams());
    value.fold((failure) {
      navigateTo = '/login';
    }, (account) {
      if (account == null) {
        navigateTo = '/login';
      } else {
        navigateTo = '/home';
      }
    });
  }
}
