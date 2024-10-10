import 'package:tasks_app/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../auth/domain/entities/account_entity.dart';
import '../repositories/check_has_logged_user_repository.dart';

abstract class CheckHasLoggedUser implements UseCase<AccountEntity?, NoParams> {
}

class CheckHasLoggedUserImp implements CheckHasLoggedUser {
  final CheckHasLoggedUserRepository repository;

  CheckHasLoggedUserImp({required this.repository});

  @override
  Future<Either<Failure, AccountEntity?>> call(NoParams params) =>
      repository.check();
}
