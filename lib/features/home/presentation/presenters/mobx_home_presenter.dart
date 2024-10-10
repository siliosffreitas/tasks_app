import 'package:mobx/mobx.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/logout.dart';
import '../ui/task_viewmodel.dart';

part 'mobx_home_presenter.g.dart';

class MobxHomePresenter = _MobxHomePresenter with _$MobxHomePresenter;

abstract class _MobxHomePresenter with Store {
  final Logout logoutUsecase;
  @observable
  String? mainError;

  @observable
  bool isLoading = false;

  @observable
  String? navigateTo;

  @observable
  List<TaskViewmodel> tasks = [];

  _MobxHomePresenter({required this.logoutUsecase});

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

    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;

    tasks = [
      TaskViewmodel(
        id: '123223123',
        title: 'Terminar esse desafio',
        description: 'Desafio da Keener',
      ),
      TaskViewmodel(
        id: '3213',
        title: 'Terminar esse desafio 2',
        description: 'Desafio da Keener',
      ),
      TaskViewmodel(
        id: 'weweqwe',
        title: 'Terminar esse desafio 4',
        description: 'Desafio da Keener',
      ),
    ];
    // mainError = 'Algum erro ocorreu';
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
