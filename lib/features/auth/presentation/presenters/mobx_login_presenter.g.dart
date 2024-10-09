// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_login_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MobxLoginPresenter on _MobxLoginPresenter, Store {
  Computed<String>? _$usernameErrorComputed;

  @override
  String get usernameError =>
      (_$usernameErrorComputed ??= Computed<String>(() => super.usernameError,
              name: '_MobxLoginPresenter.usernameError'))
          .value;
  Computed<String>? _$passwordErrorComputed;

  @override
  String get passwordError =>
      (_$passwordErrorComputed ??= Computed<String>(() => super.passwordError,
              name: '_MobxLoginPresenter.passwordError'))
          .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_MobxLoginPresenter.isFormValid'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: '_MobxLoginPresenter.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$mainErrorStreamAtom =
      Atom(name: '_MobxLoginPresenter.mainErrorStream', context: context);

  @override
  String? get mainErrorStream {
    _$mainErrorStreamAtom.reportRead();
    return super.mainErrorStream;
  }

  @override
  set mainErrorStream(String? value) {
    _$mainErrorStreamAtom.reportWrite(value, super.mainErrorStream, () {
      super.mainErrorStream = value;
    });
  }

  late final _$navigateToStreamAtom =
      Atom(name: '_MobxLoginPresenter.navigateToStream', context: context);

  @override
  String? get navigateToStream {
    _$navigateToStreamAtom.reportRead();
    return super.navigateToStream;
  }

  @override
  set navigateToStream(String? value) {
    _$navigateToStreamAtom.reportWrite(value, super.navigateToStream, () {
      super.navigateToStream = value;
    });
  }

  late final _$usernameAtom =
      Atom(name: '_MobxLoginPresenter.username', context: context);

  @override
  String? get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String? value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_MobxLoginPresenter.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$authAsyncAction =
      AsyncAction('_MobxLoginPresenter.auth', context: context);

  @override
  Future<void> auth() {
    return _$authAsyncAction.run(() => super.auth());
  }

  late final _$_MobxLoginPresenterActionController =
      ActionController(name: '_MobxLoginPresenter', context: context);

  @override
  void validateUserName(String username) {
    final _$actionInfo = _$_MobxLoginPresenterActionController.startAction(
        name: '_MobxLoginPresenter.validateUserName');
    try {
      return super.validateUserName(username);
    } finally {
      _$_MobxLoginPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String password) {
    final _$actionInfo = _$_MobxLoginPresenterActionController.startAction(
        name: '_MobxLoginPresenter.validatePassword');
    try {
      return super.validatePassword(password);
    } finally {
      _$_MobxLoginPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
mainErrorStream: ${mainErrorStream},
navigateToStream: ${navigateToStream},
username: ${username},
password: ${password},
usernameError: ${usernameError},
passwordError: ${passwordError},
isFormValid: ${isFormValid}
    ''';
  }
}
