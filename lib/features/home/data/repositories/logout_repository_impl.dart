import '../../../../core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/logout_repository.dart';
import '../datasources/logout_remote_datasource.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutRemoteDataSource dataSource;

  LogoutRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final account = await dataSource.logout();
      return Right(account);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    }
  }
}
