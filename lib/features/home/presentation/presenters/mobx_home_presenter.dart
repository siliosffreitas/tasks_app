import 'package:mobx/mobx.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/load_tasks.dart';
import '../../domain/usecases/logout.dart';
import '../ui/task_viewmodel.dart';

part 'mobx_home_presenter.g.dart';

class MobxHomePresenter = _MobxHomePresenter with _$MobxHomePresenter;

abstract class _MobxHomePresenter with Store {
  final Logout logoutUsecase;
  final LoadTasks loadTasksUsecase;

  @observable
  String? mainError;

  @observable
  bool isLoading = false;

  @observable
  String? navigateTo;

  @observable
  List<TaskViewmodel> tasks = [];

  _MobxHomePresenter({
    required this.logoutUsecase,
    required this.loadTasksUsecase,
  });

  @action
  void goToTaskPage(String id) {
    navigateTo = null;
    navigateTo = '/task/$id';
  }

  @action
  void goToNewTaskPage() {
    navigateTo = null;
    navigateTo = '/new_task';
  }

  @action
  Future<void> loadTasks() async {
    mainError = null;
    navigateTo = null;

    isLoading = true;

    final value = await loadTasksUsecase(NoParams());
    value.fold((failure) {
      isLoading = false;
      mainError = failure.message;
    }, (tasklist) {
      isLoading = false;
      tasks = tasklist
          .map((entity) => TaskViewmodel(
                id: entity.id,
                title: entity.title,
                description: entity.description,
              ))
          .toList();
    });
  }

  @action
  void showConfirmationLogout() {
    navigateTo = null;
    navigateTo = '/confirmation_logout';
  }

  @action
  Future<void> logout() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));
    await logoutUsecase(NoParams());
    isLoading = true;
    navigateTo = null;
    navigateTo = '/login';
  }
}
