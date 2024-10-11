import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../core/ui/mixins/index.dart';
import '../../../../core/ui/components/index.dart';
import '../presenters/mobx_new_task_presenter.dart';

class NewTaskPage extends StatelessWidget with LoadingManager, UiErrorManager {
  final MobxNewTaskPresenter presenter;
  const NewTaskPage({required this.presenter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova tarefa'),
      ),
      body: Builder(builder: (context) {
        reaction((_) => presenter.mainError, (_) {
          if (presenter.mainError != null) {
            showMessage(context, presenter.mainError!);
          }
        });

        reaction((_) => presenter.isLoading, (_) {
          if (presenter.isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        autorun((_) {
          if (presenter.navigateTo != null &&
              presenter.navigateTo!.isNotEmpty) {
            String page = presenter.navigateTo!;

            if (page == '/success') {
              Modular.to.pop(true);
            } else {
              Modular.to.pushNamed(page);
            }
          }
        });

        return SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Text('Título'),
                      const SizedBox(height: 4),
                      Observer(
                        builder: (_) => TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Título',
                            errorText: presenter.titleError?.isEmpty == true
                                ? null
                                : presenter.titleError,
                          ),
                          onChanged: presenter.validateTitle,
                          textCapitalization: TextCapitalization.words,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Descrição'),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 200,
                        child: Observer(
                          builder: (_) => TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Descrição',
                              errorText:
                                  presenter.descriptionError?.isEmpty == true
                                      ? null
                                      : presenter.descriptionError,
                            ),
                            onChanged: presenter.validateDescription,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            expands: true,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Observer(
                        builder: (_) => ElevatedButton(
                            onPressed: presenter.isFormValid == true
                                ? presenter.createTask
                                : null,
                            child: const Text('Criar')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
