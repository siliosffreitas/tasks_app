import 'package:mobx/mobx.dart';

part 'mobx_splash_presenter.g.dart';

class MobxSplashPresenter = _MobxSplashPresenter with _$MobxSplashPresenter;

abstract class _MobxSplashPresenter with Store {
  @observable
  String? navigateTo;

  @action
  Future<void> checkLoggedUser() async {
    await Future.delayed(const Duration(seconds: 2));
    navigateTo = '/home';
  }
}
