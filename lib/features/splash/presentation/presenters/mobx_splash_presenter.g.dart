// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_splash_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MobxSplashPresenter on _MobxSplashPresenter, Store {
  late final _$navigateToAtom =
      Atom(name: '_MobxSplashPresenter.navigateTo', context: context);

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

  late final _$checkLoggedUserAsyncAction =
      AsyncAction('_MobxSplashPresenter.checkLoggedUser', context: context);

  @override
  Future<void> checkLoggedUser() {
    return _$checkLoggedUserAsyncAction.run(() => super.checkLoggedUser());
  }

  @override
  String toString() {
    return '''
navigateTo: ${navigateTo}
    ''';
  }
}
