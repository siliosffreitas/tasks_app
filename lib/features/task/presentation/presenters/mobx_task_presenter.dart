import 'package:mobx/mobx.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../home/presentation/ui/task_viewmodel.dart';
import '../../domain/usecases/load_task.dart';

part 'mobx_task_presenter.g.dart';

class MobxTaskPresenter = _MobxTaskPresenter with _$MobxTaskPresenter;

abstract class _MobxTaskPresenter with Store {
  final LoadTask usecase;

  @observable
  String? mainError;

  @observable
  bool isLoading = false;

  @observable
  String? navigateTo;

  @observable
  TaskViewmodel? task;

  _MobxTaskPresenter({
    required this.usecase,
  });

  @action
  Future<void> loadTask(String taskId) async {
    mainError = null;
    navigateTo = null;

    isLoading = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;

    final value = await usecase(NoParams());
    value.fold((failure) {
      isLoading = false;
      mainError = failure.message;
    }, (taskReturned) {
      isLoading = false;
      task = TaskViewmodel(
        id: taskReturned.id,
        title: taskReturned.title,
        description: taskReturned.description,
      );
    });
  }
}
