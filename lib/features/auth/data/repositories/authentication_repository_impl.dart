import '../../domain/entities/account_entity.dart';

import '../../../../core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/index.dart';
import '../datasources/authentication_remote_datasource.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImp({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, AccountEntity>> login(
      String username, String password) async {
    try {
      final account = await remoteDataSource.login(username, password);
      return Right(account);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    }
  }
}
