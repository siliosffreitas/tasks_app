import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';
import 'package:tasks_app/features/signin/domain/usecases/add_account.dart';

import 'features/auth/data/datasources/authentication_remote_datasource.dart';
import 'features/auth/data/repositories/authentication_repository_impl.dart';
import 'features/auth/domain/repositories/authentication_repository.dart';
import 'features/auth/domain/usecases/authentication.dart';
import 'features/auth/presentation/presenters/mobx_login_presenter.dart';
import 'features/home/domain/repositories/logout_repository.dart';
import 'features/home/domain/usecases/logout.dart';
import 'features/home/presentation/presenters/mobx_home_presenter.dart';
import 'features/signin/data/datasources/add_account_remote_datasource.dart';
import 'features/signin/data/repositories/add_account_repository_impl.dart';
import 'features/signin/domain/repositories/add_account_repository.dart';
import 'features/signin/presentation/presenters/mobx_signin_presenter.dart';
import 'features/splash/data/datasources/check_has_logged_user_remote_datasource.dart';
import 'features/splash/data/repositories/check_has_logged_user_repository_impl.dart';
import 'features/splash/domain/repositories/check_has_logged_user_repository.dart';
import 'features/splash/domain/usecases/check_has_logged_user.dart';
import 'features/splash/presentation/presenters/mobx_splash_presenter.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        // controllers
        Bind<MobxSplashPresenter>(
            (_) => MobxSplashPresenter(Modular.get<CheckHasLoggedUser>())),
        Bind<MobxLoginPresenter>(
            (_) => MobxLoginPresenter(usecase: Modular.get<Authentication>())),

        Bind<MobxSigninPresenter>(
            (_) => MobxSigninPresenter(usecase: Modular.get<AddAccount>())),

        Bind<MobxHomePresenter>(
            (_) => MobxHomePresenter(logoutUsecase: Modular.get<Logout>())),

        // usecases
        Bind<CheckHasLoggedUser>((_) => CheckHasLoggedUserImp(
            repository: Modular.get<CheckHasLoggedUserRepository>())),

        Bind<Authentication>((_) => AuthenticationImp(
            repository: Modular.get<AuthenticationRepository>())),
        Bind<AddAccount>((_) =>
            AddAccountImp(repository: Modular.get<AddAccountRepository>())),
        Bind<Logout>(
            (_) => LogoutImp(repository: Modular.get<LogoutRepository>())),

        // repositories
        Bind<CheckHasLoggedUserRepository>((_) =>
            CheckHasLoggedUserRepositoryImp(
                remoteDataSource:
                    Modular.get<CheckHasLoggedUserRemoteDataSource>())),
        Bind<AuthenticationRepository>((_) => AuthenticationRepositoryImp(
            remoteDataSource: Modular.get<AuthenticationRemoteDataSource>())),
        Bind<AddAccountRepository>((_) => AddAccountRepositoryImp(
            remoteDataSource:
                Modular.get<AddAccountRemoteDataSourceFirebase>())),

        // datasources
        // Bind<AuthenticationRemoteDataSource>(
        //     (_) => AuthenticationRemoteDataSourceImp(Modular.get<Client>())),
        Bind<CheckHasLoggedUserRemoteDataSource>((_) =>
            CheckHasLoggedUserRemoteDataSourceFirebase(
                Modular.get<FirebaseAuth>())),
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
