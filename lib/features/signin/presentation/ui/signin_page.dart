import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../../core/ui/mixins/index.dart';
import '../../../../core/ui/components/index.dart';
import '../presenters/mobx_signin_presenter.dart';

class SigninPage extends StatelessWidget with LoadingManager, UiErrorManager {
  final MobxSigninPresenter presenter;
  const SigninPage({required this.presenter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crie sua conta fácil'),
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

        reaction((_) => presenter.navigateTo, (_) {
          if (presenter.navigateTo != null &&
              presenter.navigateTo!.isNotEmpty) {
            String page = presenter.navigateTo!;
            if (page == '/home') {
              Navigator.of(context).pushNamedAndRemoveUntil(page, (_) => false);
            } else if (page == '/success') {
              showMessage(
                context,
                'Conta criada com sucesso, viu como foi fácil, entra aí',
                onClose: () => presenter.goHome(),
              );
            } else {
              Navigator.of(context).pushNamed(page);
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
                            errorText: presenter.usernameError.isEmpty == true
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
                            errorText: presenter.passwordError.isEmpty == true
                                ? null
                                : presenter.passwordError,
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
                                presenter.passwordConfirmationError.isEmpty ==
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
                            child: const Text('Entrar')),
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
