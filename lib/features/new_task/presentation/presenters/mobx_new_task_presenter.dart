import 'package:mobx/mobx.dart';

import '../../domain/usecases/create_task.dart';

part 'mobx_new_task_presenter.g.dart';

class MobxNewTaskPresenter = _MobxNewTaskPresenter with _$MobxNewTaskPresenter;

abstract class _MobxNewTaskPresenter with Store {
  final CreateTask usecase;

  _MobxNewTaskPresenter({required this.usecase});

  @computed
  String get titleError => title == null
      ? ''
      : title!.isEmpty
          ? 'Título obrigatório'
          : '';

  @computed
  String get descriptionError => description == null
      ? ''
      : description!.isEmpty
          ? 'Descrição obrigatória'
          : '';

  @computed
  bool get isFormValid =>
      title != null &&
      title!.isNotEmpty &&
      description != null &&
      description!.isNotEmpty;

  @observable
  bool isLoading = false;

  @observable
  String? mainError;

  @observable
  String? navigateTo;

  @observable
  String? title;

  @observable
  String? description;

  @action
  void validateTitle(String title) {
    this.title = title;
  }

  @action
  void validateDescription(String description) {
    this.description = description;
  }

  @action
  Future<void> createTask() async {
    mainError = null;
    navigateTo = null;
    isLoading = true;
    final value = await usecase(CreateTaskParams(
      title: title!,
      description: description!,
    ));
    value.fold((failure) {
      isLoading = false;
      mainError = failure.message;
    }, (account) {
      isLoading = false;
      navigateTo = '/success';
    });
  }
}
