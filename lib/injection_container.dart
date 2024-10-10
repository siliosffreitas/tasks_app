import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:tasks_app/features/signin/domain/usecases/add_account.dart';

import 'features/auth/data/datasources/authentication_remote_datasource.dart';
import 'features/auth/data/repositories/authentication_repository_impl.dart';
import 'features/auth/domain/repositories/authentication_repository.dart';
import 'features/auth/domain/usecases/authentication.dart';
import 'features/auth/presentation/presenters/mobx_login_presenter.dart';
import 'features/signin/data/datasources/add_account_remote_datasource.dart';
import 'features/signin/data/repositories/add_account_repository_impl.dart';
import 'features/signin/domain/repositories/add_account_repository.dart';
import 'features/signin/presentation/presenters/mobx_signin_presenter.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        // controllers
        Bind<MobxLoginPresenter>(
            (_) => MobxLoginPresenter(usecase: Modular.get<Authentication>())),

        Bind<MobxSigninPresenter>(
            (_) => MobxSigninPresenter(usecase: Modular.get<AddAccount>())),

        // usecases
        Bind<Authentication>((_) => AuthenticationImp(
            repository: Modular.get<AuthenticationRepository>())),
        Bind<AddAccount>((_) =>
            AddAccountImp(repository: Modular.get<AddAccountRepository>())),

        // repositories
        Bind<AuthenticationRepository>((_) => AuthenticationRepositoryImp(
            remoteDataSource: Modular.get<AuthenticationRemoteDataSource>())),
        Bind<AddAccountRepository>((_) => AddAccountRepositoryImp(
            remoteDataSource:
                Modular.get<AddAccountRemoteDataSourceFirebase>())),

        // datasources
        // Bind<AuthenticationRemoteDataSource>(
        //     (_) => AuthenticationRemoteDataSourceImp(Modular.get<Client>())),
        Bind<AuthenticationRemoteDataSource>((_) =>
            AuthenticationRemoteDataSourceFirebase(
                Modular.get<FirebaseAuth>())),
        Bind<AddAccountRemoteDataSource>((_) =>
            AddAccountRemoteDataSourceFirebase(Modular.get<FirebaseAuth>())),

        // extenals
        // Bind<Client>((_) => Client()),
        Bind<FirebaseAuth>((_) => FirebaseAuth.instance),
      ];
}
