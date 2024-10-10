import 'package:mobx/mobx.dart';

part 'mobx_new_task_presenter.g.dart';

class MobxNewTaskPresenter = _MobxNewTaskPresenter with _$MobxNewTaskPresenter;

abstract class _MobxNewTaskPresenter with Store {
  // final Authentication usecase;

  _MobxNewTaskPresenter(
      // {required this.usecase}
      );

  @computed
  String get titleError => title == null
      ? ''
      : title!.isEmpty
          ? 'Título obrigatório'
          : '';

  @computed
  String get descriptionError => desciption == null
      ? ''
      : desciption!.isEmpty
          ? 'Descrição obrigatória'
          : '';

  @computed
  bool get isFormValid =>
      title != null &&
      title!.isNotEmpty &&
      desciption != null &&
      desciption!.isNotEmpty;

  @observable
  bool isLoading = false;

  @observable
  String? mainError;

  @observable
  String? navigateTo;

  @observable
  String? title;

  @observable
  String? desciption;

  @action
  void validateTitle(String title) {
    this.title = title;
  }

  @action
  void validateDescription(String desciption) {
    this.desciption = desciption;
  }

  @action
  Future<void> createTask() async {
    mainError = null;
    navigateTo = null;
    isLoading = true;
    // final value = await usecase(AuthenticationParams(
    //   username: username!,
    //   password: password!,
    // ));
    // value.fold((failure) {
    //   isLoading = false;
    //   mainError = failure.message;
    // }, (account) {
    //   isLoading = false;
    //   navigateTo = '/home';
    // });
  }
}
