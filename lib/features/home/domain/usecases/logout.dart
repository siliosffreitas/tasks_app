import '../../../../core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/logout_repository.dart';

abstract class Logout implements UseCase<void, NoParams> {}

class LogoutImp implements Logout {
  final LogoutRepository repository;

  LogoutImp({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) => repository.logout();
}
