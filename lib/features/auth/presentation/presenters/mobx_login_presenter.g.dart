// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_login_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MobxLoginPresenter on _MobxLoginPresenter, Store {
  late final _$usernameErrorAtom =
      Atom(name: '_MobxLoginPresenter.usernameError', context: context);

  @override
  String get usernameError {
    _$usernameErrorAtom.reportRead();
    return super.usernameError;
  }

  @override
  set usernameError(String value) {
    _$usernameErrorAtom.reportWrite(value, super.usernameError, () {
      super.usernameError = value;
    });
  }

  late final _$passwordErrorAtom =
      Atom(name: '_MobxLoginPresenter.passwordError', context: context);

  @override
  String get passwordError {
    _$passwordErrorAtom.reportRead();
    return super.passwordError;
  }

  @override
  set passwordError(String value) {
    _$passwordErrorAtom.reportWrite(value, super.passwordError, () {
      super.passwordError = value;
    });
  }

  late final _$isFormValidAtom =
      Atom(name: '_MobxLoginPresenter.isFormValid', context: context);

  @override
  bool get isFormValid {
    _$isFormValidAtom.reportRead();
    return super.isFormValid;
  }

  @override
  set isFormValid(bool value) {
    _$isFormValidAtom.reportWrite(value, super.isFormValid, () {
      super.isFormValid = value;
    });
  }

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

  late final _$authAsyncAction =
      AsyncAction('_MobxLoginPresenter.auth', context: context);

  @override
  Future<void> auth() {
    return _$authAsyncAction.run(() => super.auth());
  }

  late final _$_MobxLoginPresenterActionController =
      ActionController(name: '_MobxLoginPresenter', context: context);

  @override
  void validateUserName(String userName) {
    final _$actionInfo = _$_MobxLoginPresenterActionController.startAction(
        name: '_MobxLoginPresenter.validateUserName');
    try {
      return super.validateUserName(userName);
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
usernameError: ${usernameError},
passwordError: ${passwordError},
isFormValid: ${isFormValid},
isLoading: ${isLoading},
mainErrorStream: ${mainErrorStream},
navigateToStream: ${navigateToStream}
    ''';
  }
}
