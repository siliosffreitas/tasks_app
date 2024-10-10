import 'package:mobx/mobx.dart';

import '../../../../core/utils/validators.dart';
import '../../domain/usecases/authentication.dart';

part 'mobx_login_presenter.g.dart';

class MobxLoginPresenter = _MobxLoginPresenter with _$MobxLoginPresenter;

abstract class _MobxLoginPresenter with Store {
  final Authentication usecase;

  _MobxLoginPresenter({required this.usecase});

  @computed
  String get usernameError => username == null
      ? ''
      : username!.isEmpty
          ? 'E-mail obrigatório'
          : isEmailValid(username!)
              ? ''
              : 'E-mail inválido';

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
      isEmailValid(username!) &&
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
  void goToSigninPage() {
    navigateTo = null;
    navigateTo = '/signin';
  }

  @action
  Future<void> auth() async {
    mainError = null;
    navigateTo = null;
    isLoading = true;
    final value = await usecase(AuthenticationParams(
      username: username!,
      password: password!,
    ));
    value.fold((failure) {
      isLoading = false;
      mainError = failure.message;
    }, (account) {
      isLoading = false;
      navigateTo = '/home';
    });
  }
}
