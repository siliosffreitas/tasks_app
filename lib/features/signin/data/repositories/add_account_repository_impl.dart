import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/account_entity.dart';
import '../../domain/repositories/add_account_repository.dart';
import '../datasources/add_account_remote_datasource.dart';

class AddAccountRepositoryImp implements AddAccountRepository {
  final AddAccountRemoteDataSource remoteDataSource;

  AddAccountRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, AccountEntity>> signin(
      String username, String password) async {
    try {
      final account = await remoteDataSource.signin(username, password);
      return Right(account);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    }
  }
}
