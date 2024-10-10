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
        autorun((_) {
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
          if (presenter.isLoading) {
            return const SizedBox(height: 0);
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(40),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Título:'),
                    Text(
                      presenter.task!.title,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const Divider(height: 20),
                    const Text('Descrição:'),
                    Text(
                      presenter.task!.description,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      }),
    );
  }
}
