import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/ui/components/error_page.dart';
import '../../../../core/ui/components/index.dart';
import '../presenters/mobx_home_presenter.dart';
import 'task_viewmodel.dart';

class HomePage extends StatelessWidget {
  final MobxHomePresenter presenter;
  const HomePage({required this.presenter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: presenter.showConfirmationLogout,
          icon: const Icon(Icons.exit_to_app),
          tooltip: 'Deslogar',
        ),
        title: const Text('Tarefas'),
        actions: [
          IconButton(
            onPressed: presenter.goToNewTaskPage,
            icon: const Icon(Icons.add_box_rounded),
            tooltip: 'Adicionar nova tarefa',
          )
        ],
      ),
      body: Builder(builder: (context) {
        reaction((_) => presenter.isLoading, (_) {
          if (presenter.isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        reaction((_) => presenter.navigateTo, (_) {
          if (presenter.navigateTo != null &&
              presenter.navigateTo!.isNotEmpty) {
            String page = presenter.navigateTo!;

            if (page == '/confirmation_logout') {
              showConfirmationMessage(
                  context, 'Deseja realmente fazer logout?', presenter.logout);
            } else if (page == '/login') {
              Navigator.of(context).pushNamedAndRemoveUntil(page, (_) => false);
            } else {
              Navigator.of(context).pushNamed(page);
            }
          }
        });

        presenter.loadTasks();
        return Observer(
          builder: (context) {
            if (presenter.mainError != null) {
              return ErrorPage(
                error: presenter.mainError!,
                onTryAgain: presenter.loadTasks,
              );
            }
            List<TaskViewmodel> tasks = presenter.tasks;

            if (tasks.isEmpty) {
              return ErrorPage(
                  error: 'Nenhuma tarefa adicionada, adicione agora',
                  onTryAgain: presenter.goToNewTaskPage,
                  buttonLabel: 'Adicionar nova tarefa');
            }
            return RefreshIndicator(
              onRefresh: presenter.loadTasks,
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                itemBuilder: (contex, index) => Card(
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    title: Text(tasks[index].title),
                    subtitle: Text(tasks[index].description),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    onTap: () => presenter.goToTaskPage(tasks[index].id),
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.transparent,
                  height: 0,
                ),
                itemCount: tasks.length,
              ),
            );
          },
        );
      }),
    );
  }
}
