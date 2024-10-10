import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/account_entity.dart';

abstract class AddAccountRepository {
  Future<Either<Failure, AccountEntity>> signin(
      String username, String password);
}
