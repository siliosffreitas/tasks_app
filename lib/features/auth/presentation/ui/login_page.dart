import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/ui/mixins/index.dart';
import '../presenters/mobx_login_presenter.dart';

class LoginPage extends StatelessWidget with LoadingManager, UiErrorManager {
  final MobxLoginPresenter presenter;
  const LoginPage({required this.presenter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        // handleLoading(context, presenter.isLoadingStream);
        // handleMainError(context, presenter.mainErrorStream);

        // presenter.navigateToStream.listen(
        //   (page) {
        //     if (page != null && page.isNotEmpty) {
        //       Navigator.pushReplacementNamed(context, page);
        //     }
        //   },
        // );

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
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Text('Nome de usuário'),
                      const SizedBox(height: 4),
                      Observer(
                        builder: (_) => TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Nome de usuário',
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
                        ),
                      ),
                      const SizedBox(height: 40),
                      Observer(
                        builder: (_) => presenter.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Observer(
                                builder: (_) => ElevatedButton(
                                    onPressed: presenter.isFormValid == true
                                        ? presenter.auth
                                        : null,
                                    child: const Text('Entrar')),
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
