import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/ui/components/show_message.dart';
import '../../../../core/ui/components/spinner_dialog.dart';
import '../presenters/mobx_signin_presenter.dart';

class SigninPage extends StatelessWidget {
  final MobxSigninPresenter presenter;
  const SigninPage({required this.presenter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie sua conta fácil'),
      ),
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
            } else if (page == '/success') {
              showMessage(
                context,
                'Conta criada com sucesso, viu como foi fácil, entra aí',
                onClose: () => presenter.goHome(),
              );
            } else if (page == '/how_get_strong_password') {
              showMessage(
                context,
                'Para ter uma senha forte, você precisa digitar:\n• Pelo menos 8 caracteres\n• Pelo menos 1 letra maiúscula\n• Pelo menos 1 letra minúscula\n• Pelo menos 1 número\n• Pelo menos 1 caractere especial',
              );
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
                            suffixIcon: IconButton(
                                onPressed:
                                    presenter.goPasswordStrongExplanation,
                                icon: const Icon(Icons.help)),
                          ),
                          onChanged: presenter.validatePassword,
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Confirmação da Senha'),
                      const SizedBox(height: 4),
                      Observer(
                        builder: (_) => TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Confirmação da Senha',
                            errorText:
                                presenter.passwordConfirmationError?.isEmpty ==
                                        true
                                    ? null
                                    : presenter.passwordConfirmationError,
                          ),
                          onChanged: presenter.validatePasswordConfirmation,
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Observer(
                        builder: (_) => ElevatedButton(
                            onPressed: presenter.isFormValid == true
                                ? presenter.auth
                                : null,
                            child: const Text('Criar Conta')),
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
