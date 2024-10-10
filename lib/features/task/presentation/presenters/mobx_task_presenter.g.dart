// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_task_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MobxTaskPresenter on _MobxTaskPresenter, Store {
  late final _$mainErrorAtom =
      Atom(name: '_MobxTaskPresenter.mainError', context: context);

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
      Atom(name: '_MobxTaskPresenter.isLoading', context: context);

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
      Atom(name: '_MobxTaskPresenter.navigateTo', context: context);

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

  late final _$taskAtom =
      Atom(name: '_MobxTaskPresenter.task', context: context);

  @override
  TaskViewmodel? get task {
    _$taskAtom.reportRead();
    return super.task;
  }

  @override
  set task(TaskViewmodel? value) {
    _$taskAtom.reportWrite(value, super.task, () {
      super.task = value;
    });
  }

  late final _$loadTaskAsyncAction =
      AsyncAction('_MobxTaskPresenter.loadTask', context: context);

  @override
  Future<void> loadTask(String taskId) {
    return _$loadTaskAsyncAction.run(() => super.loadTask(taskId));
  }

  @override
  String toString() {
    return '''
mainError: ${mainError},
isLoading: ${isLoading},
navigateTo: ${navigateTo},
task: ${task}
    ''';
  }
}
