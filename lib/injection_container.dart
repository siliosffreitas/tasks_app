import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

import 'features/auth/data/datasources/authentication_remote_datasource.dart';
import 'features/auth/data/repositories/authentication_repository_impl.dart';
import 'features/auth/domain/repositories/authentication_repository.dart';
import 'features/auth/domain/usecases/authentication.dart';
import 'features/auth/presentation/presenters/mobx_login_presenter.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        // controllers
        Bind<MobxLoginPresenter>(
            (_) => MobxLoginPresenter(usecase: Modular.get<Authentication>())),
        // usecases
        Bind<Authentication>((_) => AuthenticationImp(
            repository: Modular.get<AuthenticationRepository>())),
        // repositories
        Bind<AuthenticationRepository>((_) => AuthenticationRepositoryImp(
            remoteDataSource: Modular.get<AuthenticationRemoteDataSource>())),

        // datasources
        // Bind<AuthenticationRemoteDataSource>(
        //     (_) => AuthenticationRemoteDataSourceImp(Modular.get<Client>())),
        Bind<AuthenticationRemoteDataSource>((_) =>
            AuthenticationRemoteDataSourceFirebase(
                Modular.get<FirebaseAuth>())),

        // extenals
        // Bind<Client>((_) => Client()),
        Bind<FirebaseAuth>((_) => FirebaseAuth.instance),
      ];
}
