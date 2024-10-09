import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/index.dart';
import '../repositories/index.dart';

abstract class Authentication
    implements UseCase<AccountEntity, AuthenticationParams> {
  @override
  Future<Either<Failure, AccountEntity>> call(AuthenticationParams params);
}

class AuthenticationImp implements Authentication {
  final AuthenticationRepository repository;

  AuthenticationImp({required this.repository});

  @override
  Future<Either<Failure, AccountEntity>> call(AuthenticationParams params) =>
      repository.login(params.username, params.password);
}

class AuthenticationParams extends Equatable {
  final String username;
  final String password;

  const AuthenticationParams({
    required this.username,
    required this.password,
  });

  @override
  List get props => [username, password];
}
