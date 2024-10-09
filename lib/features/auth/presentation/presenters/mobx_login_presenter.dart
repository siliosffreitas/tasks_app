import 'package:mobx/mobx.dart';

part 'mobx_login_presenter.g.dart';

class MobxLoginPresenter = _MobxLoginPresenter with _$MobxLoginPresenter;

abstract class _MobxLoginPresenter with Store {
  @observable
  String usernameError = '';

  @observable
  String passwordError = '';

  @observable
  bool isFormValid = false;

  @observable
  bool isLoading = false;

  @observable
  String? mainErrorStream;

  @observable
  String? navigateToStream;

  String? _username;
  String? _password;

  @action
  void validateUserName(String userName) {
    _username = userName;
    _calculateValidForm();
  }

  @action
  void validatePassword(String password) {
    _password = password;
    _calculateValidForm();
  }

  void _calculateValidForm() => isFormValid = _username != null &&
      _username!.isNotEmpty &&
      _password != null &&
      _password!.isNotEmpty;

  @action
  Future<void> auth() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
  }
}
