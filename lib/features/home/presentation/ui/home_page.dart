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
        title: const Text('Tarefas'),
        actions: [
          IconButton(
            onPressed: () {},
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

        presenter.loadTasks();
        return Observer(
          builder: (context) {
            if (presenter.mainError != null) {
              return ErrorPage(
                error: presenter.mainError!,
                onTryAgain: () {
                  presenter.loadTasks();
                },
              );
            }
            List<TaskViewmodel>? tasks = presenter.tasks;
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              itemBuilder: (contex, index) => Card(
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  title: Text(tasks![index].title),
                  subtitle: Text(tasks[index].description),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () {},
                ),
              ),
              separatorBuilder: (context, index) => const Divider(
                color: Colors.transparent,
                height: 0,
              ),
              itemCount: tasks!.length,
            );
          },
        );
      }),
    );
  }
}
