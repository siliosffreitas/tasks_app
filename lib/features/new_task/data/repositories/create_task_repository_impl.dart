import 'package:tasks_app/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/create_task_repository.dart';
import '../datasources/create_task_remote_datasource.dart';

class CreateTaskRepositoryImpl implements CreateTaskRepository {
  final CreateTaskRemoteDataSource dataSource;

  CreateTaskRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, void>> createTask(
      String title, String description) async {
    try {
      final result = await dataSource.createTask(title, description);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on UnauthorizedException {
      return const Left(UnauthorizedFailure());
    }
  }
}
