import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../presenters/mobx_splash_presenter.dart';

class SplashPage extends StatelessWidget {
  final MobxSplashPresenter presenter;
  const SplashPage({required this.presenter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        presenter.checkLoggedUser();

        autorun((_) {
          if (presenter.navigateTo != null &&
              presenter.navigateTo!.isNotEmpty) {
            String page = presenter.navigateTo!;
            Modular.to.pushNamedAndRemoveUntil(page, (_) => false);
          }
        });

        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
