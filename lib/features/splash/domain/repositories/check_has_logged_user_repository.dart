import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/account_entity.dart';

abstract class CheckHasLoggedUserRepository {
  Future<Either<Failure, AccountEntity?>> check();
}
