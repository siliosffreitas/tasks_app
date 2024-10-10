// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_new_task_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MobxNewTaskPresenter on _MobxNewTaskPresenter, Store {
  Computed<String>? _$titleErrorComputed;

  @override
  String get titleError =>
      (_$titleErrorComputed ??= Computed<String>(() => super.titleError,
              name: '_MobxNewTaskPresenter.titleError'))
          .value;
  Computed<String>? _$descriptionErrorComputed;

  @override
  String get descriptionError => (_$descriptionErrorComputed ??=
          Computed<String>(() => super.descriptionError,
              name: '_MobxNewTaskPresenter.descriptionError'))
      .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_MobxNewTaskPresenter.isFormValid'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: '_MobxNewTaskPresenter.isLoading', context: context);

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
      Atom(name: '_MobxNewTaskPresenter.mainError', context: context);

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
      Atom(name: '_MobxNewTaskPresenter.navigateTo', context: context);

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

  late final _$titleAtom =
      Atom(name: '_MobxNewTaskPresenter.title', context: context);

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$desciptionAtom =
      Atom(name: '_MobxNewTaskPresenter.desciption', context: context);

  @override
  String? get description {
    _$desciptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$desciptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$createTaskAsyncAction =
      AsyncAction('_MobxNewTaskPresenter.createTask', context: context);

  @override
  Future<void> createTask() {
    return _$createTaskAsyncAction.run(() => super.createTask());
  }

  late final _$_MobxNewTaskPresenterActionController =
      ActionController(name: '_MobxNewTaskPresenter', context: context);

  @override
  void validateTitle(String title) {
    final _$actionInfo = _$_MobxNewTaskPresenterActionController.startAction(
        name: '_MobxNewTaskPresenter.validateTitle');
    try {
      return super.validateTitle(title);
    } finally {
      _$_MobxNewTaskPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateDescription(String desciption) {
    final _$actionInfo = _$_MobxNewTaskPresenterActionController.startAction(
        name: '_MobxNewTaskPresenter.validateDescription');
    try {
      return super.validateDescription(desciption);
    } finally {
      _$_MobxNewTaskPresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
mainError: ${mainError},
navigateTo: ${navigateTo},
title: ${title},
desciption: ${description},
titleError: ${titleError},
descriptionError: ${descriptionError},
isFormValid: ${isFormValid}
    ''';
  }
}
