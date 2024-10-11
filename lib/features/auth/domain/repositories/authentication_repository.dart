import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/account_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AccountEntity>> login(
      String username, String password);
}
