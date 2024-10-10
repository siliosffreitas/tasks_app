import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/ui/components/error_page.dart';
import '../../../../core/ui/components/spinner_dialog.dart';
import '../presenters/mobx_task_presenter.dart';

class TaskPage extends StatelessWidget {
  final String taskId;
  final MobxTaskPresenter presenter;
  const TaskPage({
    required this.presenter,
    required this.taskId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefa'),
      ),
      body: Builder(builder: (context) {
        reaction((_) => presenter.isLoading, (_) {
          if (presenter.isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });
        presenter.loadTask(taskId);
        return Observer(builder: (_) {
          if (presenter.mainError != null) {
            return ErrorPage(
              error: presenter.mainError!,
              onTryAgain: () => presenter.loadTask(taskId),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Text(taskId),
                Text(presenter.task!.title),
                Text(presenter.task!.description),
              ],
            ),
          );
        });
      }),
    );
  }
}
