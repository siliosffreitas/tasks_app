import 'package:mobx/mobx.dart';
import 'package:tasks_app/core/error/failures.dart';

import '../../domain/usecases/index.dart';

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
    mainError = null;
    navigateTo = null;
    isLoading = true;
    // await Future.delayed(const Duration(seconds: 2));
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

    // mainError = 'Teste Error';
  }
}
