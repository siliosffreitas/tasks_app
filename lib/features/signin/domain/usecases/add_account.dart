import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../auth/domain/entities/account_entity.dart';
import '../repositories/add_account_repository.dart';

abstract class AddAccount implements UseCase<AccountEntity, AddAccountParams> {
  @override
  Future<Either<Failure, AccountEntity>> call(AddAccountParams params);
}

class AddAccountImp implements AddAccount {
  final AddAccountRepository repository;

  AddAccountImp({required this.repository});

  @override
  Future<Either<Failure, AccountEntity>> call(AddAccountParams params) =>
      repository.signin(params.username, params.password);
}

class AddAccountParams extends Equatable {
  final String username;
  final String password;

  const AddAccountParams({
    required this.username,
    required this.password,
  });

  @override
  List get props => [username, password];
}
