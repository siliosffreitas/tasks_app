// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_signin_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MobxSigninPresenter on _MobxSignPresenter, Store {
  Computed<String>? _$usernameErrorComputed;

  @override
  String get usernameError =>
      (_$usernameErrorComputed ??= Computed<String>(() => super.usernameError,
              name: '_MobxSignPresenter.usernameError'))
          .value;
  Computed<String>? _$passwordErrorComputed;

  @override
  String get passwordError =>
      (_$passwordErrorComputed ??= Computed<String>(() => super.passwordError,
              name: '_MobxSignPresenter.passwordError'))
          .value;
  Computed<String>? _$passwordConfirmationErrorComputed;

  @override
  String get passwordConfirmationError =>
      (_$passwordConfirmationErrorComputed ??= Computed<String>(
              () => super.passwordConfirmationError,
              name: '_MobxSignPresenter.passwordConfirmationError'))
          .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_MobxSignPresenter.isFormValid'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: '_MobxSignPresenter.isLoading', context: context);

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

  late final _$mainErrorAtom =
      Atom(name: '_MobxSignPresenter.mainError', context: context);

  @override
  String? get mainError {
    _$mainErrorAtom.reportRead();
    return super.mainError;
  }

  @override
  set mainError(String? value) {
    _$mainErrorAtom.reportWrite(value, super.mainError, () {
      super.mainError = value;
    });
  }

  late final _$navigateToAtom =
      Atom(name: '_MobxSignPresenter.navigateTo', context: context);

  @override
  String? get navigateTo {
    _$navigateToAtom.reportRead();
    return super.navigateTo;
  }

  @override
  set navigateTo(String? value) {
    _$navigateToAtom.reportWrite(value, super.navigateTo, () {
      super.navigateTo = value;
    });
  }

  late final _$usernameAtom =
      Atom(name: '_MobxSignPresenter.username', context: context);

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
      Atom(name: '_MobxSignPresenter.password', context: context);

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

  late final _$passwordConfirmationAtom =
      Atom(name: '_MobxSignPresenter.passwordConfirmation', context: context);

  @override
  String? get passwordConfirmation {
    _$passwordConfirmationAtom.reportRead();
    return super.passwordConfirmation;
  }

  @override
  set passwordConfirmation(String? value) {
    _$passwordConfirmationAtom.reportWrite(value, super.passwordConfirmation,
        () {
      super.passwordConfirmation = value;
    });
  }

  late final _$authAsyncAction =
      AsyncAction('_MobxSignPresenter.auth', context: context);

  @override
  Future<void> auth() {
    return _$authAsyncAction.run(() => super.auth());
  }

  late final _$_MobxSignPresenterActionController =
      ActionController(name: '_MobxSignPresenter', context: context);

  @override
  void validateUserName(String username) {
    final _$actionInfo = _$_MobxSignPresenterActionController.startAction(
        name: '_MobxSignPresenter.validateUserName');
    try {
      return super.validateUserName(username);
    } finally {
      _$_MobxSignPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String password) {
    final _$actionInfo = _$_MobxSignPresenterActionController.startAction(
        name: '_MobxSignPresenter.validatePassword');
    try {
      return super.validatePassword(password);
    } finally {
      _$_MobxSignPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePasswordConfirmation(String passwordConfirmation) {
    final _$actionInfo = _$_MobxSignPresenterActionController.startAction(
        name: '_MobxSignPresenter.validatePasswordConfirmation');
    try {
      return super.validatePasswordConfirmation(passwordConfirmation);
    } finally {
      _$_MobxSignPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
mainError: ${mainError},
navigateTo: ${navigateTo},
username: ${username},
password: ${password},
passwordConfirmation: ${passwordConfirmation},
usernameError: ${usernameError},
passwordError: ${passwordError},
passwordConfirmationError: ${passwordConfirmationError},
isFormValid: ${isFormValid}
    ''';
  }
}
