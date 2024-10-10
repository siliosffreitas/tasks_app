import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class LogoutRepository {
  Future<Either<Failure, void>> logout();
}
