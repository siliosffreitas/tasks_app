import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/auth/data/datasources/authentication_remote_datasource.dart';
import 'features/auth/data/repositories/authentication_repository_impl.dart';
import 'features/auth/domain/repositories/authentication_repository.dart';
import 'features/auth/domain/usecases/authentication.dart';
import 'features/auth/presentation/presenters/mobx_login_presenter.dart';
import 'features/auth/presentation/ui/login_page.dart';
import 'features/home/data/datasources/load_tasks_remote_datasource.dart';
import 'features/home/data/datasources/logout_remote_datasource.dart';
import 'features/home/data/repositories/load_tasks_repository_impl.dart';
import 'features/home/data/repositories/logout_repository_impl.dart';
import 'features/home/domain/repositories/load_tasks_repository.dart';
import 'features/home/domain/repositories/logout_repository.dart';
import 'features/home/domain/usecases/load_tasks.dart';
import 'features/home/domain/usecases/logout.dart';
import 'features/home/presentation/presenters/mobx_home_presenter.dart';
import 'features/home/presentation/ui/home_page.dart';
import 'features/new_task/data/datasources/create_task_remote_datasource.dart';
import 'features/new_task/data/repositories/create_task_repository_impl.dart';
import 'features/new_task/domain/repositories/create_task_repository.dart';
import 'features/new_task/domain/usecases/create_task.dart';
import 'features/new_task/presentation/presenters/mobx_new_task_presenter.dart';
import 'features/new_task/presentation/ui/new_task_page.dart';
import 'features/signin/data/datasources/add_account_remote_datasource.dart';
import 'features/signin/data/repositories/add_account_repository_impl.dart';
import 'features/signin/domain/repositories/add_account_repository.dart';
import 'features/signin/domain/usecases/add_account.dart';
import 'features/signin/presentation/presenters/mobx_signin_presenter.dart';
import 'features/signin/presentation/ui/signin_page.dart';
import 'features/splash/data/datasources/check_has_logged_user_remote_datasource.dart';
import 'features/splash/data/repositories/check_has_logged_user_repository_impl.dart';
import 'features/splash/domain/repositories/check_has_logged_user_repository.dart';
import 'features/splash/domain/usecases/check_has_logged_user.dart';
import 'features/splash/presentation/presenters/mobx_splash_presenter.dart';
import 'features/splash/presentation/ui/splash_page.dart';
import 'features/task/data/datasources/load_task_remote_datasource.dart';
import 'features/task/data/repositories/load_task_repository_impl.dart';
import 'features/task/domain/reposirory/load_task_repository.dart';
import 'features/task/domain/usecases/load_task.dart';
import 'features/task/presentation/presenters/mobx_task_presenter.dart';
import 'features/task/presentation/ui/task_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        // controllers
        Bind<MobxSplashPresenter>(
            (_) => MobxSplashPresenter(Modular.get<CheckHasLoggedUser>())),
        Bind<MobxLoginPresenter>(
            (_) => MobxLoginPresenter(usecase: Modular.get<Authentication>()),
            isSingleton: false),
        Bind<MobxSigninPresenter>(
            (_) => MobxSigninPresenter(usecase: Modular.get<AddAccount>())),
        Bind<MobxHomePresenter>((_) => MobxHomePresenter(
              logoutUsecase: Modular.get<Logout>(),
              loadTasksUsecase: Modular.get<LoadTasks>(),
            )),
        Bind<MobxNewTaskPresenter>(
            (_) => MobxNewTaskPresenter(usecase: Modular.get<CreateTask>())),

        Bind<MobxTaskPresenter>(
            (_) => MobxTaskPresenter(usecase: Modular.get<LoadTask>())),

        // usecases
        Bind<CheckHasLoggedUser>((_) => CheckHasLoggedUserImp(
            repository: Modular.get<CheckHasLoggedUserRepository>())),

        Bind<Authentication>((_) => AuthenticationImp(
            repository: Modular.get<AuthenticationRepository>())),
        Bind<AddAccount>((_) =>
            AddAccountImp(repository: Modular.get<AddAccountRepository>())),
        Bind<Logout>(
            (_) => LogoutImp(repository: Modular.get<LogoutRepository>())),
        Bind<CreateTask>((_) =>
            CreateTaskImp(repository: Modular.get<CreateTaskRepository>())),
        Bind<LoadTasks>((_) =>
            LoadTasksImp(repository: Modular.get<LoadTasksRepository>())),
        Bind<LoadTask>(
            (_) => LoadTaskImp(repository: Modular.get<LoadTaskRepository>())),

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
        Bind<LogoutRepository>((_) => LogoutRepositoryImpl(
            dataSource: Modular.get<LogoutRemoteDataSource>())),

        Bind<CreateTaskRepository>((_) => CreateTaskRepositoryImpl(
            dataSource: Modular.get<CreateTaskRemoteDataSource>())),
        Bind<LoadTasksRepository>((_) => LoadTasksRepositoryImpl(
            dataSource: Modular.get<LoadTasksRemoteDataSource>())),
        Bind<LoadTaskRepository>((_) => LoadTaskRepositoryImpl(
            dataSource: Modular.get<LoadTaskRemoteDataSource>())),

        // datasources

        Bind<CheckHasLoggedUserRemoteDataSource>((_) =>
            CheckHasLoggedUserRemoteDataSourceFirebase(
                Modular.get<FirebaseAuth>())),
        Bind<AuthenticationRemoteDataSource>((_) =>
            AuthenticationRemoteDataSourceFirebase(
                Modular.get<FirebaseAuth>())),
        Bind<AddAccountRemoteDataSource>((_) =>
            AddAccountRemoteDataSourceFirebase(Modular.get<FirebaseAuth>())),
        Bind<LogoutRemoteDataSource>(
            (_) => LogoutRemoteDataSourceFirebase(Modular.get<FirebaseAuth>())),
        Bind<CreateTaskRemoteDataSource>((_) =>
            CreateTaskRemoteDataSourceFirebase(
                firestore: Modular.get<FirebaseFirestore>(),
                firebaseInstance: Modular.get<FirebaseAuth>())),
        Bind<LoadTasksRemoteDataSource>((_) =>
            LoadTasksRemoteDataSourceFirebase(
                firestore: Modular.get<FirebaseFirestore>(),
                firebaseInstance: Modular.get<FirebaseAuth>())),
        Bind<LoadTaskRemoteDataSource>((_) => LoadTaskRemoteDataSourceFirebase(
              firestore: Modular.get<FirebaseFirestore>(),
            )),

        // extenals
        Bind<FirebaseAuth>((_) => FirebaseAuth.instance),
        Bind<FirebaseFirestore>((_) => FirebaseFirestore.instance),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/splash',
            child: (context, args) =>
                SplashPage(presenter: Modular.get<MobxSplashPresenter>())),
        ChildRoute('/login',
            child: (context, args) =>
                LoginPage(presenter: Modular.get<MobxLoginPresenter>())),
        ChildRoute('/signin',
            child: (context, args) =>
                SigninPage(presenter: Modular.get<MobxSigninPresenter>())),
        ChildRoute('/home',
            child: (context, args) =>
                HomePage(presenter: Modular.get<MobxHomePresenter>())),
        ChildRoute('/new_task',
            child: (context, args) => NewTaskPage(
                  presenter: Modular.get<MobxNewTaskPresenter>(),
                )),
        ChildRoute('/task',
            child: (context, args) => TaskPage(
                presenter: Modular.get<MobxTaskPresenter>(),
                taskId: args.data['task_id'])),
      ];
}
