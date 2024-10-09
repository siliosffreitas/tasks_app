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
        Bind<MobxLoginPresenter>(
            (_) => MobxLoginPresenter(usecase: Modular.get<Authentication>())),
        Bind<Authentication>((_) => AuthenticationImp(
            repository: Modular.get<AuthenticationRepository>())),
        Bind<AuthenticationRepository>((_) => AuthenticationRepositoryImp(
            remoteDataSource: Modular.get<AuthenticationRemoteDataSource>())),
        Bind<AuthenticationRemoteDataSource>(
            (_) => AuthenticationRemoteDataSourceImp(Modular.get<Client>())),
        Bind<Client>((_) => Client()),
      ];
}
