import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/account_entity.dart';
import '../../domain/repositories/check_has_logged_user_repository.dart';
import '../datasources/check_has_logged_user_remote_datasource.dart';

class CheckHasLoggedUserRepositoryImp implements CheckHasLoggedUserRepository {
  final CheckHasLoggedUserRemoteDataSource remoteDataSource;

  CheckHasLoggedUserRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, AccountEntity?>> check() async {
    try {
      final account = await remoteDataSource.check();
      return Right(account);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    }
  }
}
