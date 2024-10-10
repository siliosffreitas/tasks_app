import 'package:mobx/mobx.dart';

import '../../../home/presentation/ui/task_viewmodel.dart';

part 'mobx_task_presenter.g.dart';

class MobxTaskPresenter = _MobxTaskPresenter with _$MobxTaskPresenter;

abstract class _MobxTaskPresenter with Store {
  // final Logout logoutUsecase;
  // final LoadTasks loadTasksUsecase;

  @observable
  String? mainError;

  @observable
  bool isLoading = false;

  @observable
  String? navigateTo;

  @observable
  TaskViewmodel? task;

  _MobxTaskPresenter(
      // {
      // required this.logoutUsecase,
      // required this.loadTasksUsecase,
      // }
      );

  @action
  Future<void> loadTask(String taskId) async {
    mainError = null;
    navigateTo = null;

    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    task = TaskViewmodel(
        id: '123123123', title: '123123', description: 'sdfasrgdafvdzxfvgd');

    // final value = await loadTasksUsecase(NoParams());
    // value.fold((failure) {
    //   isLoading = false;
    //   mainError = failure.message;
    // }, (tasklist) {
    //   isLoading = false;
    //   tasks = tasklist
    //       .map((entity) => TaskViewmodel(
    //             id: entity.id,
    //             title: entity.title,
    //             description: entity.description,
    //           ))
    //       .toList();
    // });
  }
}
