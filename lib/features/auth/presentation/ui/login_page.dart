import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/ui/components/show_message.dart';
import '../../../../core/ui/components/spinner_dialog.dart';
import '../../../../core/ui/mixins/error_message_manager.dart';
import '../../../../core/ui/mixins/loading_manager.dart';
import '../presenters/mobx_login_presenter.dart';

class LoginPage extends StatelessWidget with LoadingManager, UiErrorManager {
  final MobxLoginPresenter presenter;
  const LoginPage({required this.presenter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        autorun((_) {
          if (presenter.mainError != null) {
            showMessage(context, presenter.mainError!);
          }
        });

        autorun((_) {
          if (presenter.isLoading) {
            SpinnerDialog.showLoading(context);
          } else {
            SpinnerDialog.hideLoading(context);
          }
        });

        autorun((_) {
          if (presenter.navigateTo != null &&
              presenter.navigateTo!.isNotEmpty) {
            String page = presenter.navigateTo!;
            if (page == '/home') {
              Modular.to.pushNamedAndRemoveUntil(page, (_) => false);
            } else {
              Modular.to.pushNamed(page);
            }
          }
        });

        return SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.elliptical(200, 30),
                      bottomRight: Radius.elliptical(200, 30),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Center(
                    child: Text(
                      'Bem-vindo ao Lista de tarefas by Silio',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Text('E-mail'),
                      const SizedBox(height: 4),
                      Observer(
                        builder: (_) => TextFormField(
                          decoration: InputDecoration(
                            hintText: 'E-mail',
                            errorText: presenter.usernameError?.isEmpty == true
                                ? null
                                : presenter.usernameError,
                          ),
                          onChanged: presenter.validateUserName,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Senha'),
                      const SizedBox(height: 4),
                      Observer(
                        builder: (_) => TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            errorText: presenter.passwordError?.isEmpty == true
                                ? null
                                : presenter.passwordError,
                          ),
                          onChanged: presenter.validatePassword,
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Observer(
                        builder: (_) => ElevatedButton(
                            onPressed: presenter.isFormValid == true
                                ? presenter.auth
                                : null,
                            child: const Text('Entrar')),
                      ),
                      TextButton(
                        onPressed: presenter.goToSigninPage,
                        child: const Text(
                          'Criar conta',
                          style: TextStyle(color: Colors.black),
                        ),
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
