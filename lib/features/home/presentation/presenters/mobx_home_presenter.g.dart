// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_home_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MobxHomePresenter on _MobxHomePresenter, Store {
  late final _$mainErrorAtom =
      Atom(name: '_MobxHomePresenter.mainError', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: '_MobxHomePresenter.isLoading', context: context);

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

  late final _$navigateToAtom =
      Atom(name: '_MobxHomePresenter.navigateTo', context: context);

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

  late final _$tasksAtom =
      Atom(name: '_MobxHomePresenter.tasks', context: context);

  @override
  List<TaskViewmodel>? get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(List<TaskViewmodel>? value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$loadTasksAsyncAction =
      AsyncAction('_MobxHomePresenter.loadTasks', context: context);

  @override
  Future<void> loadTasks() {
    return _$loadTasksAsyncAction.run(() => super.loadTasks());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_MobxHomePresenter.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$_MobxHomePresenterActionController =
      ActionController(name: '_MobxHomePresenter', context: context);

  @override
  void goToTaskPage(String id) {
    final _$actionInfo = _$_MobxHomePresenterActionController.startAction(
        name: '_MobxHomePresenter.goToTaskPage');
    try {
      return super.goToTaskPage(id);
    } finally {
      _$_MobxHomePresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToNewTaskPage() {
    final _$actionInfo = _$_MobxHomePresenterActionController.startAction(
        name: '_MobxHomePresenter.goToNewTaskPage');
    try {
      return super.goToNewTaskPage();
    } finally {
      _$_MobxHomePresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showConfirmationLogout() {
    final _$actionInfo = _$_MobxHomePresenterActionController.startAction(
        name: '_MobxHomePresenter.showConfirmationLogout');
    try {
      return super.showConfirmationLogout();
    } finally {
      _$_MobxHomePresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mainError: ${mainError},
isLoading: ${isLoading},
navigateTo: ${navigateTo},
tasks: ${tasks}
    ''';
  }
}
