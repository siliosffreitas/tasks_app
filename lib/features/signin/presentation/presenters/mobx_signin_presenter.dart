import 'package:mobx/mobx.dart';

import '../../../../core/utils/validators.dart';

part 'mobx_signin_presenter.g.dart';

class MobxSigninPresenter = _MobxSignPresenter with _$MobxSigninPresenter;

abstract class _MobxSignPresenter with Store {
  // final Authentication usecase;

  _MobxSignPresenter(//{required this.usecase}
      );

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
  String get passwordConfirmationError => passwordConfirmation == null
      ? ''
      : passwordConfirmation!.isEmpty
          ? 'Confirmação obrigatória'
          : passwordConfirmation == password!
              ? ''
              : 'Confirmação errada';

  @computed
  bool get isFormValid =>
      username != null &&
      username!.isNotEmpty &&
      isEmailValid(username!) &&
      password != null &&
      password!.isNotEmpty &&
      passwordConfirmation != null &&
      passwordConfirmation!.isNotEmpty;

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

  @observable
  String? passwordConfirmation;

  @action
  void validateUserName(String username) {
    this.username = username;
  }

  @action
  void validatePassword(String password) {
    this.password = password;
  }

  @action
  void validatePasswordConfirmation(String passwordConfirmation) {
    this.passwordConfirmation = passwordConfirmation;
  }

  @action
  Future<void> auth() async {
    mainError = null;
    navigateTo = null;
    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));
    // final value = await usecase(AuthenticationParams(
    //   username: username!,
    //   password: password!,
    // ));
    // value.fold((failure) {
    //   isLoading = false;
    //   mainError = failure.message;
    // }, (account) {
    //   isLoading = false;
    //   navigateTo = '/home';
    // });

    isLoading = false;
    mainError = 'Teste Error';
  }
}