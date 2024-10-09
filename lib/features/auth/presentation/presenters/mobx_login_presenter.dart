import 'package:mobx/mobx.dart';

part 'mobx_login_presenter.g.dart';

class MobxLoginPresenter = _MobxLoginPresenter with _$MobxLoginPresenter;

abstract class _MobxLoginPresenter with Store {
  @computed
  String get usernameError => username == null
      ? ''
      : username!.isEmpty
          ? 'E-mail obrigatório'
          : '';

  @computed
  String get passwordError => password == null
      ? ''
      : password!.isEmpty
          ? 'Senha obrigatória'
          : '';

  @computed
  bool get isFormValid =>
      username != null &&
      username!.isNotEmpty &&
      password != null &&
      password!.isNotEmpty;

  @observable
  bool isLoading = false;

  @observable
  String? mainError;

  @observable
  String? navigateTo;

  @observable
  String? username;

  @observable
  String? password;

  @action
  void validateUserName(String username) {
    this.username = username;
  }

  @action
  void validatePassword(String password) {
    this.password = password;
  }

  @action
  Future<void> auth() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
  }
}
