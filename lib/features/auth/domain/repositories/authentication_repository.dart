import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/index.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AccountEntity>> login(
      String username, String password);
}
